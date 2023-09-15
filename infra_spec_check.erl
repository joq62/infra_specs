-module(infra_spec_check).

-export([
	 start/0,
	 %% Support
	 all_files/0,
	 all_info/0
	]).


-define(Dir,".").
-define(FileExt,".host").

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
start()->
    
    check(all_info()),
    init:stop(),
    ok.

check([])->
    io:format("Success, OK ! ~n");
check([{ok,[{infra_spec,Info}]}|T])->
    io:format("Checking ~p~n",[Info]),
    true=proplists:is_defined(spec_id,Info),
    true=proplists:is_defined(cookie_str,Info),
    true=proplists:is_defined(num_workers,Info),
    check(T).

   

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
all_files()->
    {ok,Files}=file:list_dir(?Dir),
    FileNames=[filename:join(?Dir,Filename)||Filename<-Files,
					     ?FileExt=:=filename:extension(Filename)],
    FileNames.    
all_info()->
    [file:consult(File)||File<-all_files()].
	    
    
