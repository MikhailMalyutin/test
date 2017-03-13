import ceylon.http.server {
    newServer,
    Endpoint,
    startsWith,
    equals
}
import ceylon.http.common {
    post,
    get
}
import ceylon.io {
    SocketAddress
}
import ru.msm.test.service.config {
    serverName,
    serverPort
}
import ru.msm.test.service.web.utils {
    wrapLogErrors
}

import ru.msm.test.service.web.logic {
    processAccount,
    processRegister,
    processStatistic,
    processRedirect
}

shared void startHttpServer() {
    value server = newServer {
        Endpoint {
            path = equals("/account");
            wrapLogErrors(processAccount);
            acceptMethod = [post];
        },
        Endpoint {
            path = equals("/register");
            wrapLogErrors(processRegister);
            acceptMethod = [post];
        },
        Endpoint {
            path = startsWith("/statistic");
            wrapLogErrors(processStatistic);
            acceptMethod = [get];
        },
        Endpoint {
            path = startsWith("/");
            wrapLogErrors(processRedirect);
            acceptMethod = [get];
        }
    };
    server.start(SocketAddress(serverName, serverPort));
}