import grails.config.Config
import grails.core.support.GrailsConfigurationAware
import grails.plugins.rest.client.RestBuilder
import grails.plugins.rest.client.RestResponse

class PreferencesService implements GrailsConfigurationAware {

    String basePath
    String accessToken

    @Override
    void setConfiguration(Config co) {
        basePath = co.getProperty('preferences.basePath', String)
        accessToken = co.getProperty('accessToken', String)
    }

    def create(def preference){
        String url = "${basePath}?access_token=${accessToken}"
        RestResponse restResponse = new RestBuilder().post(url) {
            contentType("application/json")
            body(preference)
        }
        return restResponse.json
    }

    def get(String id){
        String url = "${basePath}/${id}?access_token=${accessToken}"
        RestResponse restResponse = new RestBuilder().get(url) {
            accept("application/json")
        }
        return restResponse.json
    }

}
