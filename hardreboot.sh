#!/usr/bin/env bash

hexo clean
hexo generate --draft
hexo server -s -l
