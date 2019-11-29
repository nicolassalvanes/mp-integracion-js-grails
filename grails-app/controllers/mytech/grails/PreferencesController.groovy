package mytech.grails

class PreferencesController {

    static allowedMethods = [save: 'POST']

    def preferencesService
	
    def save() {
        response.setContentType("application/json")
        render preferencesService.create(request.JSON.toString())
    }

}
