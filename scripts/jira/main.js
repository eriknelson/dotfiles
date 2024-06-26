const fs = require('fs');
const path = require('path');

const jiraUser = process.env['JIRA_USER'];
const jiraPass = process.env['JIRA_PASS'];
const readFile = process.env['READFILE'];
const nskGitDir = process.env['NSK_GIT_DIR'];

if(!jiraUser || !jiraPass) {
  console.error(`ERROR: Must provide JIRA_USER and JIRA_PASS env vars`);
  return;
}

const jqlQuery =
  'project = SKY'

//const jqlQuery =
  //'project = SKY' +
  //'sprint = 63 and ' +
  //'"Story point estimate" is EMPTY AND ' +
  //'(labels not in (cms-transition) OR labels is EMPTY) and ' +
  //'type != Epic and ' +
  //'assignee not in (60e473aee7b4fd006a663348, 623b1fb64a57610068e6d094, 61f16b7b5a0988006b3d9a61, 6213c40b347c690072f60a0b, 62f14c25c1b3a10ac3aba159, 628fb588cf01a10069ae992d)'

const { JiraClient } = require(path.join(
  nskGitDir, 'wadsworth','jira-client'));

(async () => {
  let resObj;
  if(readFile) {
    resObj = JSON.parse(fs.readFileSync(readFile));
    console.log(`count: ${resObj.issues.length}`)
    const co = {};
    resObj.issues.forEach(i => {
      const adn = i.fields.assignee.displayName;
      if(!(adn in co)) {
        co[adn] = 1;
      } else {
        co[adn] = co[adn] + 1;
      }
    });
    console.log('countObj:');
    console.log(co);
    //resObj.issues.map(i => ({
      //summary: i.fields.summary,
      //key: i.key,
      //link: i.self,
    //})).forEach(i => console.log(`\n[${i.key}] ${i.summary}\n=> https://issues.redhat.com/browse/${i.key}`));
  } else {
    const jc = new JiraClient(jiraUser, jiraPass);
    resObj = await jc.JQLQuery(jqlQuery);
    console.log(JSON.stringify(resObj));
  }
})()
