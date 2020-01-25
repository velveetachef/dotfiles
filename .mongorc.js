// Improve the default prompt with hostname, process type, and version
function prompt() {
    const serverstatus = db.serverStatus();
    const host = serverstatus.host.split('.')[0];
    const serverProcess = serverstatus.serverProcess;
    const version = db.serverBuildInfo().version;
    const replSet = db._adminCommand({ "replSetGetStatus": 1 }).ok !== 0;
    let rsState = '';

    if (replSet) {
        const { members, set: rsName } = rs.status();

        members.forEach((i, index) => {
            if (members[i].self === true) {
                rsState = '[' + members[i].stateStr + ':' + rsName + ']';
            }
        });
    }

    return `${host}[${serverProcess}-${version}]${rsState} ${db}> `
}

// default to pretty print
DBQuery.prototype._prettyShell = true;

// command to disable pretty print for result
DBQuery.prototype.ugly = function () {
    this._prettyShell = false;

    return this;
};
