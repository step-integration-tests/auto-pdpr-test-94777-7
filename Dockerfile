FROM --platform=linux/x86_64 amazonlinux:2

FROM amazonlinux:2023 as build_env

FROM python:3.12.2-slim@sha256:5dc6f84b5e97bfb0c90abfb7c55f3cacc2cb6687c8f920b64a833a2219875997

FROM ghcr.io/aquasecurity/trivy:0.48.0@sha256:27448497c3ae9cb81bdac3b420226392422b976a921f7461caf97ce5b591dcc0

FROM mcr.microsoft.com/dotnet/runtime:8.0.3 AS dotnet_runtime

# ------------------------------------------------

FROM amazonlinux:2023

RUN yum install -y python3

FROM alpine:3.18.6@sha256:11e21d7b981a59554b3f822c49f6e9f57b6068bb74f49c4cd5cc4c663c7e5160

RUN apk add --no-cache bash

FROM python:3.7.17@sha256:eedf63967cdb57d8214db38ce21f105003ed4e4d0358f02bedc057341bcf92a0

RUN pip install requests

RUN useradd --system --create-home --shell /bin/bash clamavuser

EXPOSE 8000
USER clamavuser
WORKDIR /home/clamavuser

ENV PATH="/home/clamavuser/.local/bin:${PATH}"
RUN \
    python -m pip install --user setuptools
RUN \
    python -m pip install --user cvdupdate==1.1.1 && \
    cvd update
