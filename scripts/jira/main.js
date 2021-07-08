const fs = require('fs');

const jiraUser = process.env['JIRA_USER'];
const jiraPass = process.env['JIRA_PASS'];
const readFile = process.env['READFILE'];

if(!jiraUser || !jiraPass) {
  console.error(`ERROR: Must provide JIRA_USER and JIRA_PASS env vars`);
  return;
}

const { JiraClient } = require('/Users/ernelson/git/wadsworth/jira-client');

(async () => {
  let resObj;
  if(readFile) {
    resObj = JSON.parse(fs.readFileSync(readFile));
    resObj.issues.map(i => ({
      summary: i.fields.summary,
      key: i.key,
      link: i.self,
    })).forEach(i => console.log(`\n[${i.key}] ${i.summary}\n=> https://issues.redhat.com/browse/${i.key}`));
  } else {
    const jc = new JiraClient(jiraUser, jiraPass);
    resObj = await jc.JQLMigSearch('project = MIG AND fixVersion = "MTC 1.5.0" AND labels = mtc-lab-update');
    console.log(JSON.stringify(resObj));
  }

})()
