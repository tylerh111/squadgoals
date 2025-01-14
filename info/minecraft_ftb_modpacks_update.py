"""
Updates modpack details (.csv and .json).

See the following sites:
- https://www.feed-the-beast.com/modpacks/server-files
- https://api.feed-the-beast.com/v1/modpacks/public/modpack
- https://modpacksch.docs.apiary.io/
"""

from __future__ import annotations

import json
import csv
import time
from dataclasses import dataclass

import requests


SAVE_MODPACK_TO_CSV = True
SAVE_MODPACK_TO_JSON = False

URL_FTB_API_MODPACKS = "https://api.feed-the-beast.com/v1/modpacks/public/modpack"
DELAY_REQUESTS = 10
DELAY_REQUESTS_TIME = 0.5


minecraft_ftb_modpacks_known_ids = [
    1, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
    19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
    35, 36, 37, 47, 52, 54, 56, 58, 59, 60, 61, 62, 65, 66, 70, 72,
    73, 74, 75, 76, 77, 78, 79, 80, 86, 88, 90, 91, 93, 94, 95, 96,
    97, 99, 100, 101, 102, 103, 107, 108, 109, 110, 111, 114, 115, 117, 119, 120,
    121, 122, 123, 124, 125, 126,
]


@dataclass
class Modpack:
    id: int
    idv: str
    name: str
    slug: str
    version: str
    required_game: str
    required_game_version: str
    required_modloader: str
    required_modloader_version: str
    required_runtime: str
    required_runtime_version: str
    url_modpack: str
    url_modpack_version: str
    contents: dict


def modpack_format_url(id: int) -> dict:
    return f"{URL_FTB_API_MODPACKS}/{id}"


def modpack_format_url_version(id: int, version: int) -> dict:
    return f"{URL_FTB_API_MODPACKS}/{id}/{version}"


def modpack_fetch_contents(id: int) -> dict:
    url = modpack_format_url(id=id)
    res = requests.get(url=url)
    if res.ok:
        return json.loads(res.text)

    raise RuntimeError(f"error: request result no ok: {url=} {res.text=}")


def modpack_find_target_info(targets: list[dict], type: str) -> tuple[str, ...]:
    for target in targets:
        if target["type"] == type:
            return target["name"], target["version"]

    return "", ""


def modpack_extract_info(contents: dict) -> list[Modpack]:
    modpack = contents
    modpacks = []
    for modpackver in modpack["versions"]:
        url_modpack = modpack_format_url(modpack["id"])
        url_modpack_version = modpack_format_url_version(modpack["id"], modpackver["id"])
        required_game = modpack_find_target_info(modpackver["targets"], type="game")
        required_modloader = modpack_find_target_info(modpackver["targets"], type="modloader")
        required_runtime = modpack_find_target_info(modpackver["targets"], type="runtime")
        modpacks.append(
            Modpack(
                id=modpack["id"],
                idv=modpackver["id"],
                name=modpack["name"],
                version=modpackver["name"],
                slug=modpack["slug"],
                required_game=required_game[0],
                required_game_version=required_game[1],
                required_modloader=required_modloader[0],
                required_modloader_version=required_modloader[1],
                required_runtime=required_runtime[0],
                required_runtime_version=required_runtime[1],
                url_modpack=url_modpack,
                url_modpack_version=url_modpack_version,
                contents=modpack,
            )
        )

    return modpacks


def modpack_to_csv_header() -> list[str]:
    return [
        "id",
        "idv",
        "slug",
        "version",
        "required_game",
        "required_game_version",
        "required_modloader",
        "required_modloader_version",
        "required_runtime",
        "required_runtime_version",
        "url_modpack",
        "url_modpack_version",
    ]


def modpack_to_csv(modpack: Modpack) -> list[str]:
    return [
        modpack.id,
        modpack.idv,
        modpack.slug,
        modpack.version,
        modpack.required_game,
        modpack.required_game_version,
        modpack.required_modloader,
        modpack.required_modloader_version,
        modpack.required_runtime,
        modpack.required_runtime_version,
        modpack.url_modpack,
        modpack.url_modpack_version,
    ]


def build_csv():

    modpacks: list[Modpack] = []
    delay = DELAY_REQUESTS

    for id in minecraft_ftb_modpacks_known_ids:
        print(f"modpack: {id}", end="\r")
        contents = modpack_fetch_contents(id=id)
        extracted = modpack_extract_info(contents=contents)
        print(f"modpack: {id} {[mp.idv for mp in extracted]} (found)")
        modpacks.extend(extracted)

        if not (delay := delay - 1):
            time.sleep(DELAY_REQUESTS_TIME)
            delay = DELAY_REQUESTS

    if SAVE_MODPACK_TO_CSV:
        with open("minecraft_ftb_modpacks.csv", "w", encoding="utf-8") as f:
            writer = csv.writer(f, lineterminator=",\n")
            writer.writerow(modpack_to_csv_header())
            for modpack in modpacks:
                writer.writerow(modpack_to_csv(modpack))

    if SAVE_MODPACK_TO_JSON:
        contents = [modpack.contents for modpack in modpacks]
        with open("minecraft_ftb_modpacks.json", "w", encoding="utf-8") as f:
            json.dump(contents, f, indent=2)


if __name__ == "__main__":
    build_csv()
