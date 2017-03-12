import net.gyokuro.core {
    get,
    Application
}
shared void startHttpServer() {
    get("/hello", (req, resp) => "Hello, world!");

    Application().run();
}