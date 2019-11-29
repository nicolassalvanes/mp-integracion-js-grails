package mytech.grails

import groovy.json.JsonBuilder

class PaymentController {
    def preferencesService
    def paymentsService

    def button() {
        def preference = preferencesService.get(params.get('preference_id'))
        if(preference.init_point) {
            render view: "button", model: [initPoint: preference.init_point]
        } else {
            redirect uri: '/notFound'
        }
    }

    def custom(){
        response.setContentType("application/json")
        def result = paymentsService.create(params)
        def builder = new JsonBuilder()
        builder {
            status "${result.status}"
            detail "${result.status_detail}"
        }
        render builder.toPrettyString()
    }
}
