import logging
from datetime import UTC, datetime


class Iso8601WithTimezoneFormatter(logging.Formatter):
    def formatTime(
        self,
        record: logging.LogRecord,
        datefmt: str | None = None,
    ) -> str:
        return (
            datetime.fromtimestamp(record.created, UTC)
            .astimezone()
            .isoformat(sep="T", timespec="milliseconds")
        )


def setup_logger(
    logger: logging.Logger,
    log_level: int,
    log_file: str | None,
) -> None:
    logger.setLevel(log_level)

    stream_handler = logging.StreamHandler()
    stream_handler.setLevel(log_level)
    stream_handler.setFormatter(
        Iso8601WithTimezoneFormatter(
            fmt="%(asctime)s %(levelname)s: %(message)s",
        )
    )

    logger.addHandler(stream_handler)

    if log_file is not None:
        file_handler = logging.FileHandler(log_file)
        file_handler.setLevel(log_level)
        file_handler.setFormatter(
            Iso8601WithTimezoneFormatter(
                fmt="%(asctime)s %(levelname)s: %(message)s",
            )
        )

        logger.addHandler(file_handler)
