import ru.msm.test.service.web {
    startHttpServer
}
import ceylon.logging {
    Logger,
    logger,
    addLogWriter,
    writeSimpleLog
}

shared Logger log = logger(`module`);

shared void run() {
    addLogWriter(writeSimpleLog);

    startHttpServer();
}