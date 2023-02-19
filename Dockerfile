# syntax=docker/dockerfile:1.4
FROM python:3.10 AS base-env

RUN <<EOF
    apt-get update
    apt-get install -y \
        gosu
    apt-get clean
    rm -rf /var/apt/lists/*
EOF

RUN <<EOF
    groupadd -o -g 1000 user
    useradd -o -m -u 1000 -g user user
EOF


FROM base-env AS bedrock-updater-runtime-env

WORKDIR /work
ADD ./requirements-bedrock-updater.txt /work/
RUN gosu user pip3 install --no-cache-dir -r /work/requirements-bedrock-updater.txt

ADD ./aoirint_mcping /work/aoirint_mcping
ADD ./aoirint_mcping_bedrock_updater.py /work/

ENV MCPING_BEDROCK_UPDATER_LOOP=1

CMD [ "gosu", "user", "python3", "aoirint_mcping_bedrock_updater.py" ]



FROM base-env AS java-updater-runtime-env

WORKDIR /work
ADD ./requirements-java-updater.txt /work/
RUN gosu user pip3 install --no-cache-dir -r /work/requirements-java-updater.txt

ADD ./aoirint_mcping /work/aoirint_mcping
ADD ./aoirint_mcping_java_updater.py /work/

ENV MCPING_JAVA_UPDATER_LOOP=1

CMD [ "gosu", "user", "python3", "aoirint_mcping_java_updater.py" ]


FROM base-env AS web-api-runtime-env

WORKDIR /work
ADD ./requirements-web-api.txt /work/
RUN gosu user pip3 install --no-cache-dir -r /work/requirements-web-api.txt

ADD ./aoirint_mcping /work/aoirint_mcping
ADD ./aoirint_mcping_web_api.py /work/

ENV MCPING_WEB_API_HOST=0.0.0.0

CMD [ "gosu", "user", "python3", "aoirint_mcping_web_api.py" ]
