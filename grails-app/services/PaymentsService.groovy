import grails.config.Config
import grails.core.support.GrailsConfigurationAware
import grails.plugins.rest.client.RestBuilder
import grails.plugins.rest.client.RestResponse
import groovy.json.JsonBuilder

class PaymentsService implements GrailsConfigurationAware {

    String basePath
    String accessToken

    @Override
    void setConfiguration(Config co) {
        basePath = co.getProperty('payments.basePath', String)
        accessToken = co.getProperty('accessToken', String)
    }

    def create(def params){
        String url = "${basePath}?access_token=${accessToken}"

        def builder = new JsonBuilder()
        builder {
            token "${params.token}"
            payment_method_id "${params.paymentMethodId}"
            issuer_id "${params.issuer}"
            transaction_amount params.float('amount')
            installments params.int('installments')
            payer {
                email "${params.email}"
            }
        }
        System.out.print(builder.toPrettyString())
        RestResponse restResponse = new RestBuilder().post(url) {
            contentType("application/json")
            body(builder.toString())
        }
        return restResponse.json
    }

}
