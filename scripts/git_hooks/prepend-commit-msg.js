#!/usr/bin/env node
const fs = require('fs')
const path = require('path')
const { execSync } = require('child_process')

/*
 *  Prepends the commit message with the branch name and branch number.
 *
 *  Takes one argument: the path to the temporary file containing the commit message.
 *
 *  The content of that file is to be modified in place according to some rules :
 *  - if the commit message starts with `[#` the commit message will be considered already tagged and will not be modified.
 *  - if the branch is `feature/23_some_new_thing` the commit message will be preprended with `[#23 some new thing]`.
 *  - if the branch is `feature/tech_some_new_thing` the commit message will be preprended with `[#TECH some new thing]`.
 *  - in any other case the commit message will not be modified.
 */

console.log('[prepend-commit-msg] Checking commit message...')

const commitMsgFilePath = path.join(process.cwd(), process.env.HUSKY_GIT_PARAMS)
const commitMsg = fs.readFileSync(commitMsgFilePath, { encoding: 'utf-8' })
const branchName = execSync('git rev-parse --abbrev-ref HEAD', { encoding: 'utf-8' })
  .split('\n')[0]

const commitMsgIsAlreadyTagged = commitMsg.match(/^\[#/)
const branchIsFeatureStory = branchName.match(/^feature\/\d+_/)
const branchIsFeatureTech = branchName.match(/^feature\/tech_/)

if (!commitMsgIsAlreadyTagged && branchIsFeatureTech) {
  newCommitMsg = generateFeatureTechCommitMsg(commitMsg, branchName)
  console.log(`[prepend-commit-msg] New commit message : ${newCommitMsg}`)
  replaceCommitMsg(newCommitMsg, commitMsgFilePath)

} else if (!commitMsgIsAlreadyTagged && branchIsFeatureStory) {
  newCommitMsg = generateFeatureStoryCommitMsg(commitMsg, branchName)
  console.log(`[prepend-commit-msg] New commit message : ${newCommitMsg}`)
  replaceCommitMsg(newCommitMsg.split('\n')[0], commitMsgFilePath)

} else {
  console.log('[prepend-commit-msg] Commit message not to be modified')
}

console.log('[prepend-commit-msg] Script done')

function generateFeatureTechCommitMsg (unalteredCommitMsg, fullBranchName) {
  const matches = fullBranchName.match(/^feature\/tech_(?<branchName>.+)$/)
  const branchName = matches.groups.branchName
  const featureName = branchName.replace(/_/g, ' ')

  return `[#TECH ${featureName}] ${unalteredCommitMsg}`
}

function generateFeatureStoryCommitMsg (unalteredCommitMsg, fullBranchName) {
  const matches = fullBranchName.match(/^feature\/(?<number>\d+)_(?<branchName>.+)$/)
  const branchName = matches.groups.branchName
  const featureNumber = matches.groups.number
  const featureName = branchName.replace(/_/g, ' ')

  return `[#${featureNumber} ${featureName}] ${unalteredCommitMsg}`
}

function replaceCommitMsg (newCommitMsg, commitMsgFilePath) {
  fs.writeFileSync(commitMsgFilePath, newCommitMsg, { encoding: 'utf-8' })
}
