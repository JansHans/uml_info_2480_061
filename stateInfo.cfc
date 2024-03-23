component {
    
    function obtainUser(
        isLoggedIn = 0,
        firstname="", 
        lastname="", 
        email="", 
        accountNumber="", 
        isAdmin = 0
        ) {
        return {
        "isLoggedIn":arguments.isLoggedIn,
        "firstname": arguments.firstname,
        "lastname": arguments.lastname,
        "email": arguments.email,
        "accountNumber":arguments.accountNumber,
        "isAdmin":arguments.isAdmin
        }
        
    }

    function processNewAccount(formData){
        var retme = {
            success:false, message:""
        }
        if(emailUnique(formData.email)){
            var newId = createuuid();
            if(addPassword(newId, formData.password)){
                addAccount(newId, formData.title, formData.firstname, formData.lastname, formData.email);
                retme.success=true;
                retme.message = "Welcome! Your account was created. Please login.";
            } else {
                retme.message = "There was a problem. Please resubmit.";
            }
        } else {
            retme.message = "That email is already registered. Please log in.";
        }
        return retme;
    }

    function emailUnique(required string email){
        var qs = new query(datasource=application.dsource);
        qs.setSql("SELECT * FROM people WHERE email=:email");
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
        writeDump(arguments);
            var qs = new query(datasource=application.dsource);
            qs.setSql(
                "SELECT * FROM people 
                INNER JOIN passwords ON people.personid=passwords.personid
                WHERE email=:email and passwords.password=:password"
                );
            qs.addParam(
                name="email", 
                value=arguments.username
                );
            qs.addParam(
                name="password", 
                value=hash(arguments.password,"SHA-512")
                );
            return qs.execute().getResult();
    }

            
                
       
        
}
