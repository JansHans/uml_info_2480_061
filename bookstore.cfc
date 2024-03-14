component {

    function obtainSearchResults( searchMe ) {
        var qs = new query(datasource.);
        qs.setSql("select * from books where title like :searchme;")
        qs.addParam(name="searchme", value="%#searchme#%")
        return qs.execute().getResult();
    }
}