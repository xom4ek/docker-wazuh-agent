#!/usr/bin/env bash
set -ve
NODE_NAME=$(cat /host/etc/hostname) ./register_agent.py
