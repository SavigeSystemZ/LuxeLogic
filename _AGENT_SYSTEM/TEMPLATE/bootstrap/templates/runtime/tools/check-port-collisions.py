#!/usr/bin/env python3
from __future__ import annotations

import re
import sys
from pathlib import Path


def parse_ports_yaml(path: Path) -> list[dict[str, str | int]]:
    if not path.exists():
        return []

    entries: list[dict[str, str | int]] = []
    current: dict[str, str | int] | None = None
    for raw_line in path.read_text().splitlines():
        line = raw_line.rstrip()
        match_name = re.match(r"^\s*-\s+name:\s*(.+)$", line)
        if match_name:
            if current:
                entries.append(current)
            current = {"name": match_name.group(1).strip()}
            continue
        if current is None:
            continue
        for key in ("port", "bind_address", "source"):
            match = re.match(rf"^\s+{re.escape(key)}:\s*(.+)$", line)
            if not match:
                continue
            value = match.group(1).strip()
            current[key] = int(value) if key == "port" and value.isdigit() else value
    if current:
        entries.append(current)
    return entries


def parse_backend_assignments(path: Path) -> list[dict[str, str | int]]:
    if not path.exists():
        return []

    entries: list[dict[str, str | int]] = []
    current: dict[str, str | int] | None = None
    for raw_line in path.read_text().splitlines():
        line = raw_line.rstrip()
        match_name = re.match(r"^\s*-\s+name:\s*(.+)$", line)
        if match_name:
            if current:
                entries.append(current)
            current = {"name": match_name.group(1).strip()}
            continue
        if current is None:
            continue
        for key in ("host_port", "exposure", "owner_path"):
            match = re.match(rf"^\s+{re.escape(key)}:\s*(.+)$", line)
            if not match:
                continue
            value = match.group(1).strip()
            current[key] = int(value) if key == "host_port" and value.isdigit() else value
    if current:
        entries.append(current)
    return entries


def main() -> int:
    root = Path(sys.argv[1]).resolve() if len(sys.argv) > 1 else Path.cwd()
    ports_path = root / "registry" / "ports.yaml"
    backends_path = root / "registry" / "backend-assignments.yaml"

    seen: dict[tuple[str, int], list[str]] = {}
    for entry in parse_ports_yaml(ports_path):
        port = int(entry.get("port", 0) or 0)
        if port <= 0:
            continue
        bind = str(entry.get("bind_address", "127.0.0.1") or "127.0.0.1")
        label = str(entry.get("name", "unknown"))
        seen.setdefault((bind, port), []).append(f"ports.yaml:{label}")

    for entry in parse_backend_assignments(backends_path):
        port = int(entry.get("host_port", 0) or 0)
        if port <= 0:
            continue
        bind = "127.0.0.1"
        label = str(entry.get("name", "unknown"))
        seen.setdefault((bind, port), []).append(f"backend-assignments.yaml:{label}")

    collisions = [(key, labels) for key, labels in seen.items() if len(labels) > 1]
    if collisions:
        for (bind, port), labels in collisions:
            print(f"port collision on {bind}:{port} -> {', '.join(labels)}", file=sys.stderr)
        return 1

    print("port_registry_ok")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
