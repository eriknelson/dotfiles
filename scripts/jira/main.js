const fs = require('fs');

const jiraUser = process.env['JIRA_USER'];
const jiraPass = process.env['JIRA_PASS'];
const readFile = process.env['READFILE'];

if(!jiraUser || !jiraPass) {
  console.error(`ERROR: Must provide JIRA_USER and JIRA_PASS env vars`);
  return;
}

const { JiraClient } = require('/git/wadsworth/jira-client');

(async () => {
  let resObj;
  if(readFile) {
    resObj = JSON.parse(fs.readFileSync(readFile));
    resObj.issues.map(i => ({
      summary: i.fields.summary,
      key: i.key,
      link: i.self,
    })).forEach(i => console.log(`\n[${i.key}] ${i.summary}\n=> ${i.link}`));
  } else {
    const jc = new JiraClient(jiraUser, jiraPass);
    resObj = await jc.JQLMigSearch('project = MIG AND fixVersion = "MTC 1.4.1" AND labels = mtc141-depro');
    console.log(JSON.stringify(resObj));
  }

})()
