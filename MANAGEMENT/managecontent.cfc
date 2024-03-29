component {
   
    function processForms( required struct formData ){
        
        if (formData.keyExists( "id" ) && formData.keyExists("title") && formData.title.len() > 0) {

        var qs = new query( datasource = application.dsource );
        qs.setSql( "
            IF NOT EXISTS( SELECT * FROM content WHERE id=:id)
                INSERT INTO content (id,title) VALUES (:id,:title);
        
            UPDATE content SET
                title=:title,
                description=:description
            WHERE id=:id
            " );
        qs.addParam(
            name      = "id",
            cfsqltype = "CF_SQL_NVARCHAR",
            value     = trim(formData.id),
            null      = formData.id.len() != 35 
        );
        qs.addParam(
            name      = "title",
            cfsqltype = "CF_SQL_NVARCHAR",
            value     = trim(formData.title),
            null      = formData.title.len()==0
        );
         qs.addParam(
            name      = "description",
            cfsqltype = "CF_SQL_NVARCHAR",
            value     = trim(formData.description),
            null      = trim(formData.description).len() == 0
         );
        qs.execute();

        // is this needed below for the manage content area??
        
        // check if the content in form exists
        // and then turn list of content to an array
        // and for every item in the array, run the function
        // the item is the id for each item until finsih array
        // and also pass in the formData.id

        // if(formData.keyExists("content")){

        //     deleteAllContents(formData.id)

        //     formData.content.listToArray().each(function(item){
        //         insertContent(item, formData.id)
        //     })
        
        // }
        
        }
    }

    function sideContentNav(qTerm){
        if(qTerm.len() == 0) {
            return queryNew("title");
        } else {
            var qs = new query(datasource=application.dsource);
            qs.setSql("select * from content where title like :qterm order by title");
            qs.addParam(name="qTerm", value="%#qterm#%");
            return qs.execute().getResult();
        }
    }

    function contentDetails(id){
        var qs = new query(datasource=application.dsource);
        qs.setSql("select * from content where id=:id");
        qs.addParam(
            name      = "id",
            cfsqltype = "CF_SQL_NVARCHAR",
            value     = arguments.id);
        return qs.execute().getResult();
    }

    function allContents(id) {
        var qs = new query(datasource=application.dsource);
        qs.setSql("select * from content order by title");
        return qs.execute().getResult();
    }

    function insertContent(id){
        var qs = new query(datasource=application.dsource);
        qs.setSql("insert into content (id) VALUES ( :id ) ");
        qs.addParam(name="id", value=arguments.id);
        qs.execute();
    }

    // is this function below needed?
    // function deleteAllContents(id){
    //     var qs = new query(datasource=application.dsource);
    //     qs.setSql("delete from content WHERE id=:id");
    //     qs.addParam(name="id", value=arguments.id);
    //     qs.execute();
    // }

    // current content titles and articles is contentContents
    function contentContents(id) {
        var qs = new query(datasource = application.dsource);
        qs.setSql("select * from content where id=:id");
        qs.addParam(name="id", value = arguments.id);
        return qs.execute().getResult();
    }

}
