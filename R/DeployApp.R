#' @title Deploy the app to shiny server.
#' @name DeployApp
#' @rdname DeployApp
#' @export DeployApp
#' @aliases DeployApp
#' @description  DeployApp() will deploy the app.
#' @usage DeployApp()


DeployApp <- function() {
  
  rsconnect::setAccountInfo(
    name   = 'bccdc',
    token  = 'your_token',
    secret = 'your_secret'
  )
  
  rsconnect::deployApp(
    appName  = 'my_app',
    appId    = '1234',
    appDir   = getwd(),
    account  = 'bccdc',
    upload   = T,
    logLevel = 'verbose',
    appVisibility = 'private',
    forceUpdate = TRUE
  )
  
}
