package drylungs.web;

typedef Record = Dynamic;

class Records extends Site {

    var records : Array<Record>;

    public function new() {
        super();
		records = Json.parse( File.getContent( Drylungs.DATA+'/records.json' ) );
    }

    function doDefault( ?id : String ) {
        switch id {
        case null, '', '/':
            doAll();
        default:

            var record = getRecordById( id );
            if( record == null )
                throw DispatchError.DENotFound(  id );

            this.id = 'record';
            site.title = 'Drylungs.$id';

            //TODO twitter:player card

            site.twitter = {
                title: site.title,
                description: record.description,
                image: 'image/record/$id.jpg',

            };
            //site.keywords.push( id );
            print( record );
        }
	}

    function doFeed( d : Dispatch ) {
    	d.dispatch( new drylungs.web.Feed( records ) );
    }

    function doAll() {
        print( { records: records } );
    }

    inline function doList() doAll();

    function getRecordById( id : String ) {
        for( r in records ) if( r.id == id ) return r;
        return null;
    }

}
