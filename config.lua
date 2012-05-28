static_lgcms = { type="dir", base='sites/lgcms/', index_file='index.html', default_ctype='' }

handler_lgcms = { type="handler", send_spec='tcp://127.0.0.1:10001',
                send_ident='ba06f707-8647-46b9-b7f7-e641d6419909',
                recv_spec='tcp://127.0.0.1:10002', recv_ident=''}

lgcms = {
    bind_addr = "0.0.0.0",
    uuid="505417b8-1de4-454f-98b6-07eb9225cca1",
    access_log="logs/access.log",
    error_log="logs/error.log",
    chroot="./",
    pid_file="run/mongrel2.pid",
    default_host="lgcms",
    name="lgcms",
    port=6767,
    hosts= { 
		{   
			name="lgcms",
			matching = "xxxxxx", 
			routes={ 
				['/'] = handler_lgcms,
                		['/media/'] = static_lgcms
			} 
        },
    }
}

static_xinst = { type="dir", base='sites/xinst/', index_file='index.html', default_ctype='' }
handler_xinst = { type="handler", send_spec='tcp://127.0.0.1:10005',
                send_ident='ba06f707-8647-46b9-b7f7-e641d6419910',
                recv_spec='tcp://127.0.0.1:10006', recv_ident=''}
xinst = {
    bind_addr = "0.0.0.0",
    uuid="505417b8-1de4-454f-98b6-07eb9225cca2",
    access_log="logs/access-1.log",
    error_log="logs/error-1.log",
    chroot="./",
    pid_file="run/mongrel2.pid",
    default_host="xinst",
    name="xinst",
    port=6768,
    hosts= { 
		{   
			name="xinst",
			matching = "xxxxxx", 
			routes={ 
				['/'] = handler_xinst,
                		['/media/'] = static_xinst
			} 
        },
    }
}


static_monitor = { type="dir", base='sites/monitor/', index_file='index.html', default_ctype='' }
handler_monitor = { type="handler", send_spec='tcp://127.0.0.1:10003',
                send_ident='ba06f707-8647-46b9-b7f7-e641d6419911',
                recv_spec='tcp://127.0.0.1:10004', recv_ident=''}
monitor = {
    bind_addr = "0.0.0.0",
    uuid="505417b8-1de4-454f-98b6-07eb9225cca3",
    access_log="logs/access-1.log",
    error_log="logs/error-1.log",
    chroot="./",
    pid_file="run/monserver.pid",
    default_host="monitor",
    name="monitor",
    port=6770,
    hosts= { 
		{   
			name="monitor",
			matching = "xxxxxx", 
			routes={ 
				['/'] = handler_monitor,
                		['/media/'] = static_monitor
			} 
        },
    }
}

settings = {	
	['zeromq.threads'] = 1, 
	['limits.content_length'] = 200971520, 
	['upload.temp_store'] = '/tmp/monserver.upload.XXXXXX' 
}


servers = { lgcms,xinst, monitor }

