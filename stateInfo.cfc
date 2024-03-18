component {

    function obtainUser() {
        return {
        isLoggedIn:"",
        firstname: "",
        lastname: "",
        email: "",
        acctNumber:"",
        isAdmin=0
    }
}

    function processNewAccount(formData){
        var retme = {
            success:false, message:""
        }

        if(emailUnique(formdata.email)){
            var newId = createuuid();
            if (addPassword(newId, formData.password ) ) {
                addAccount(newId, formData.title, formData.firstname, formData.lastname, formData.email);
                retme.success=true;
                retme.message = "Your new account was created! Please login.";
            } else {
                retme.message = "There was a problem. Please resubmit.";
            }
        } else {
            retme.message = "That email is already in our database. Please log in.";
        }
        return retme;
    }

    function emailUnique(required string email) {
        var qs = new query(datasource = application.dsource);
        qs.setSql("select * from people where email=:email");
        qs.addParam(
            name="email", 
            value=arguments.email
            );
        return qs.execute().getResult().recordcount == 0;
    }

    function addPassword(id, password){
        try {
            var qs = new query(datasource = application.dsource);
            qs.setSql("insert into passwords (personid, password)
            values (:personid, :password) ");
            qs.addParam(
                name = "personid", 
                value = arguments.id);
            qs.addParam(
                name = "password", 
                value = hash(arguments.password, "SHA-512")
                );
                qs.execute();
                return true;
            } catch(any err){
                writeDump(err); abort;
              return false;
            }
        }

        function addAccount(id, title, firstname, lastname, email, isAdmin){
            try {
                var qs = new query(datasource = application.dsource);
                qs.setSql("insert into people (personid, title, firstname, lastname, email, isAdmin)
                values (:personid, :title, :firstname, :lastname, :email, :isAdmin) ");
                qs.addParam(
                    name = "personid", 
                    value = arguments.id
                    );
                qs.addParam(
                    name = "title", 
                    value = arguments.title
                    );
                qs.addParam(
                    name = "firstname", 
                    value = arguments.firstname
                    );
                qs.addParam(
                    name = "lastname", 
                    value = arguments.lastname
                    );
                qs.addParam(
                    name = "email", 
                    value = arguments.email
                    );
                qs.addParam(
                        name = "isAdmin", 
                        value = arguments.isAdmin
                        );    
                
                qs.execute();
                    return true;
                } catch(any err){
                    writeDump(err); abort;
                  return false;
                }
            }

            function logMeIn(username, password){
                var qs = new query(datasource=application.dsource);
                qs.setSql("
                SELECT * FROM people
                INNER JOIN passwords ON people.id=passwords.personid
                WHERE email=:email and password=:password");
                qs.addParam(
                    name="email", 
                    value=arguments.username
                    );
                qs.addParam(
                    name="password", 
                    value=hash(form.loginpass,"SHA-512")
                    );
                return qs.execute().getResult();
               }
                
       
}
