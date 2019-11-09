// Improve the default prompt with hostname, process type, and version
var prompt = function () {
    var serverstatus = db.serverStatus();
    var host = serverstatus.host.split('.')[0];
    var process = serverstatus.process;
    var version = db.serverBuildInfo().version;
    var repl_set = db._adminCommand({ "replSetGetStatus": 1 }).ok !== 0;
    var rs_state = '';

    if (repl_set) {
        var status = rs.status();
        var members = status.members;
        var rs_name = status.set;

        for (var i = 0; i < members.length; i++) {
            if (members[i].self === true) {
                rs_state = '[' + members[i].stateStr + ':' + rs_name + ']';
            }
        }
    }

    // not working
    // var state = isMongos() ? '[mongos]' : rs_state;

    var state = rs_state;

    return host + '(' + process + '-' + version + ')' + state + ' ' + db + '> ';
};

// default to pretty print
DBQuery.prototype._prettyShell = true;

// command to disable pretty print for result
DBQuery.prototype.ugly = function () {
    this._prettyShell = false;

    return this;
};
