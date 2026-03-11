#!/usr/bin/env python3

import subprocess as _subprocess


def test_ret_code(caplog) -> None:
    run_hello = _subprocess.run(["out/hello"], capture_output=True, text=True)
    assert run_hello.returncode == 0


def test_comma(caplog) -> None:
    run_hello = _subprocess.run(["out/hello"], capture_output=True, text=True)
    assert ", World" in run_hello.stdout


def test_hello() -> None:
    run_hello = _subprocess.run(["out/hello"], capture_output=True, text=True)
    assert "Hello" in run_hello.stdout
