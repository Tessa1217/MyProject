/**
 * 
 */

class MyFileUploadAdapter {
	constructor(loader) {
		this.loader = loader;
		this.url = "/board/imageUpload.do";
	}
	upload() {
		return new Promise((resolve, reject) => {
			this._initRequest();
			this._initListeners(resolve, reject);
			this._sendRequest();
		});
	}
	abort() {
		if (this.xhr) {
			this.xhr.abort();
		}
	}
	_initRequest() {
		const xhr = this.xhr = new XMLHttpRequest();
		xhr.open('POST', this.url, true);
		xhr.responseType = 'json';
	}
	 _initListeners( resolve, reject ) {
	        const xhr = this.xhr;
	        const loader = this.loader;
	        const genericErrorText = 'Couldn\'t upload file:' + ` ${ loader.file.name }.`;

	        xhr.addEventListener( 'error', () => reject( genericErrorText ) );
	        xhr.addEventListener( 'abort', () => reject() );
	        xhr.addEventListener( 'load', () => {
	            const response = xhr.response;

	            if ( !response || response.error ) {
	                return reject( response && response.error ? response.error.message : genericErrorText );
	            }

	            // If the upload is successful, resolve the upload promise with an object containing
	            // at least the "default" URL, pointing to the image on the server.
	            resolve( {
	                default: response.url
	            } );
	        } );

	        if ( xhr.upload ) {
	            xhr.upload.addEventListener( 'progress', evt => {
	                if ( evt.lengthComputable ) {
	                    loader.uploadTotal = evt.total;
	                    loader.uploaded = evt.loaded;
	                }
	            } );
	        }
	    }
	 _sendRequest() {
	        const data = new FormData();

	        data.append( 'upload', this.loader.file );

	        this.xhr.send( data );
	    }
}