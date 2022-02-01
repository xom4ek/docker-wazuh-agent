#!/usr/bin/env bash
set -ve
pwd
cd /var/ossec/
./init.sh || true
pwd
./register_agent.py
