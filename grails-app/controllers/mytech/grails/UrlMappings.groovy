package mytech.grails

class UrlMappings {

    static mappings = {
        "/"(controller: 'application', action: 'index')
        post "/preferences"(controller: 'preferences', action: 'save')
        get "/payment/button?"(controller: 'payment', action: 'button')
        get "/payment/custom"(view: '/payment/custom')
        post "/payment/custom"(controller: 'payment', action: 'custom')
        "500"(view: '/error')
        "404"(view: '/notFound')
    }
}
