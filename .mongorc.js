function prompt() {
    // const { host, version, process: serverProcess } = db.serverStatus();
    const { me } = db.isMaster();
    const replSet = db._adminCommand({ "replSetGetStatus": 1 }).ok !== 0;
    let rsState = '';

    if (replSet) {
        const { members, set: rsName } = rs.status();

        members.forEach((member) => {
            if (member.self === true) {
                rsState = `[${member.stateStr}:${rsName}]`;
            }
        });
    }

    // return `${host}[${serverProcess}-${version}]${rsState} ${db}}> `
    return `${me} ${db}> `
}

// default to pretty print
DBQuery.prototype._prettyShell = true;

// command to disable pretty print for result
DBQuery.prototype.ugly = function () {
    this._prettyShell = false;

    return this;
};
