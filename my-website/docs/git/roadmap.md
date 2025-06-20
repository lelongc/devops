# Git Complete Learning Roadmap - Chi tiết từng topic

## 🎯 Mục tiêu: Master Git từ A-Z trong 6-8 tháng

## 🔰 GIAI ĐOẠN 1: GIT FOUNDATION (Tháng 1-2)

### Week 1: Git Fundamentals

**Search Keywords để học:**

- [ ] "What is Git version control system"
- [ ] "Git vs SVN vs Mercurial comparison"
- [ ] "Distributed version control vs centralized"
- [ ] "Git history and Linus Torvalds"
- [ ] "Why use version control system"
- [ ] "Git installation Windows MacOS Linux"
- [ ] "Git configuration first time setup"
- [ ] "Git working directory staging area repository"

**Practical Setup:**

- [ ] Install Git on your system
- [ ] Configure Git username and email
- [ ] Understand Git three-tree architecture
- [ ] Create first Git repository

**Commands để practice:**

```bash
# Installation verification
git --version
which git

# First-time configuration
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global init.defaultBranch main
git config --list
git config --global --edit
```

### Week 2: Basic Git Operations

**Search Keywords để học:**

- [ ] "Git init create new repository"
- [ ] "Git add staging area tutorial"
- [ ] "Git commit message best practices"
- [ ] "Git status check repository state"
- [ ] "Git log view commit history"
- [ ] "Git diff compare changes"
- [ ] "Git repository states working staging committed"
- [ ] "Git file lifecycle untracked modified staged"

**Commands để practice:**

```bash
# Repository creation
git init
git init --bare
git clone <url>

# Basic workflow
git status
git add filename
git add .
git add -A
git add -u
git commit -m "commit message"
git commit -am "add and commit"

# Viewing changes
git diff
git diff --staged
git diff HEAD
git log
git log --oneline
git log --graph
```

### Week 3: Working with Files

**Search Keywords để học:**

- [ ] "Git add remove files from repository"
- [ ] "Git rm delete files from Git"
- [ ] "Git mv rename move files"
- [ ] "Git reset unstage files"
- [ ] "Git checkout discard changes"
- [ ] "Git restore new way to discard changes"
- [ ] "Gitignore file patterns tutorial"
- [ ] "Git clean remove untracked files"

**Commands để practice:**

```bash
# File operations
git rm filename
git rm --cached filename
git mv old_name new_name

# Undoing changes
git reset HEAD filename
git checkout -- filename
git restore filename
git restore --staged filename

# Cleaning
git clean -n
git clean -f
git clean -fd

# Gitignore
echo "*.log" >> .gitignore
echo "node_modules/" >> .gitignore
git add .gitignore
```

### Week 4: Commit History & Navigation

**Search Keywords để học:**

- [ ] "Git log advanced options formatting"
- [ ] "Git show display commit details"
- [ ] "Git reflog reference logs"
- [ ] "Git checkout navigate commit history"
- [ ] "Git HEAD pointer explanation"
- [ ] "Git detached HEAD state"
- [ ] "Git commit SHA hash explained"
- [ ] "Git relative commit references HEAD~1 HEAD^"

**Commands để practice:**

```bash
# Viewing history
git log --pretty=format:"%h %s"
git log --graph --all
git log --author="name"
git log --since="2 weeks ago"
git log --grep="bug"
git log filename

# Navigation
git show HEAD
git show commit_hash
git checkout commit_hash
git checkout HEAD~1
git checkout HEAD^
git reflog
```

## 🌿 GIAI ĐOẠN 2: BRANCHING & MERGING (Tháng 3)

### Week 5: Git Branching Basics

**Search Keywords để học:**

- [ ] "Git branch create switch delete"
- [ ] "Git branching model workflow"
- [ ] "Git branch vs tag difference"
- [ ] "Git checkout vs switch command"
- [ ] "Git branch naming conventions"
- [ ] "Git local vs remote branches"
- [ ] "Git tracking branches upstream"
- [ ] "Git branch strategies GitFlow GitHub Flow"

**Commands để practice:**

```bash
# Branch creation and switching
git branch
git branch new_branch
git checkout new_branch
git switch new_branch
git checkout -b feature_branch
git switch -c feature_branch

# Branch management
git branch -v
git branch -a
git branch -r
git branch -d branch_name
git branch -D branch_name
git branch -m old_name new_name
```

### Week 6: Merging Strategies

**Search Keywords để học:**

- [ ] "Git merge fast-forward vs three-way"
- [ ] "Git merge commit vs squash merge"
- [ ] "Git merge conflicts resolution"
- [ ] "Git rebase vs merge difference"
- [ ] "Git merge strategies recursive octopus"
- [ ] "Git merge tools configuration"
- [ ] "Git cherry-pick specific commits"
- [ ] "Git merge --no-ff preserve history"

**Commands để practice:**

```bash
# Merging
git merge branch_name
git merge --no-ff branch_name
git merge --squash branch_name

# Conflict resolution
git status (during conflict)
git add resolved_file
git commit (complete merge)
git merge --abort

# Cherry-picking
git cherry-pick commit_hash
git cherry-pick -n commit_hash

# Merge tools
git mergetool
git config --global merge.tool vimdiff
```

### Week 7: Rebasing Mastery

**Search Keywords để học:**

- [ ] "Git rebase interactive tutorial"
- [ ] "Git rebase vs merge when to use"
- [ ] "Git rebase --onto advanced usage"
- [ ] "Git rebase conflicts resolution"
- [ ] "Git rebase --continue --skip --abort"
- [ ] "Git interactive rebase squash fixup"
- [ ] "Git rebase rewrite commit history"
- [ ] "Golden rule of rebasing public commits"

**Commands để practice:**

```bash
# Basic rebase
git rebase master
git rebase --onto master server client

# Interactive rebase
git rebase -i HEAD~3
git rebase -i commit_hash

# Rebase operations
git rebase --continue
git rebase --skip
git rebase --abort

# Rebase options in interactive mode
# pick, reword, edit, squash, fixup, drop
```

### Week 8: Advanced History Manipulation

**Search Keywords để học:**

- [ ] "Git reset soft mixed hard difference"
- [ ] "Git revert vs reset vs checkout"
- [ ] "Git reflog recover lost commits"
- [ ] "Git filter-branch rewrite history"
- [ ] "Git BFG repo cleaner tool"
- [ ] "Git commit --amend modify last commit"
- [ ] "Git stash save work in progress"
- [ ] "Git bisect find bug-introducing commit"

**Commands để practice:**

```bash
# Reset variations
git reset --soft HEAD~1
git reset --mixed HEAD~1
git reset --hard HEAD~1

# Reverting
git revert commit_hash
git revert -n commit_hash

# Stashing
git stash
git stash push -m "message"
git stash list
git stash apply
git stash pop
git stash drop

# History rewriting
git commit --amend
git commit --amend --no-edit
git filter-branch --tree-filter 'rm -f password.txt' HEAD
```

## 🌐 GIAI ĐOẠN 3: REMOTE REPOSITORIES (Tháng 4)

### Week 9: Remote Repositories Setup

**Search Keywords để học:**

- [ ] "Git remote add origin push pull"
- [ ] "Git clone vs fork difference"
- [ ] "Git remote upstream downstream"
- [ ] "SSH keys for Git authentication"
- [ ] "HTTPS vs SSH Git authentication"
- [ ] "Git credential manager setup"
- [ ] "Git remote URL change update"
- [ ] "Multiple Git remotes management"

**Commands để practice:**

```bash
# Remote management
git remote
git remote -v
git remote add origin <url>
git remote add upstream <url>
git remote set-url origin <new_url>
git remote remove origin

# SSH setup
ssh-keygen -t rsa -b 4096 -C "email@example.com"
ssh-add ~/.ssh/id_rsa
ssh -T git@github.com

# Credential setup
git config --global credential.helper cache
git config --global credential.helper store
```

### Week 10: Push & Pull Operations

**Search Keywords để học:**

- [ ] "Git push pull fetch difference"
- [ ] "Git push force vs force-with-lease"
- [ ] "Git pull vs fetch and merge"
- [ ] "Git tracking branches setup"
- [ ] "Git push upstream set-upstream"
- [ ] "Git pull request workflow"
- [ ] "Git fetch all branches from remote"
- [ ] "Git push tags to remote repository"

**Commands để practice:**

```bash
# Pushing
git push origin main
git push -u origin feature_branch
git push --all origin
git push --tags
git push --force-with-lease

# Pulling and fetching
git fetch origin
git fetch --all
git pull origin main
git pull --rebase origin main

# Tracking branches
git branch -u origin/main
git push --set-upstream origin feature_branch
git branch -vv
```

### Week 11: Collaboration Workflows

**Search Keywords để học:**

- [ ] "Git workflow patterns comparison"
- [ ] "Centralized workflow Git"
- [ ] "Feature branch workflow"
- [ ] "Gitflow workflow branching model"
- [ ] "Forking workflow open source"
- [ ] "GitHub flow vs Git flow"
- [ ] "Git collaboration best practices"
- [ ] "Code review process with Git"

**Workflow Patterns:**

```bash
# Feature Branch Workflow
git checkout -b feature/new-feature
# ... make changes ...
git push -u origin feature/new-feature
# ... create pull request ...

# Gitflow commands (with git-flow extension)
git flow init
git flow feature start new-feature
git flow feature finish new-feature
git flow release start 1.0.0
git flow hotfix start critical-bug

# Forking Workflow
git clone <your-fork>
git remote add upstream <original-repo>
git fetch upstream
git checkout -b feature-branch upstream/main
```

### Week 12: Conflict Resolution & Collaboration

**Search Keywords để học:**

- [ ] "Git merge conflicts advanced resolution"
- [ ] "Git rebase conflicts during collaboration"
- [ ] "Git conflict resolution tools comparison"
- [ ] "Git merge vs rebase in team environment"
- [ ] "Git hooks for team collaboration"
- [ ] "Git attributes configuration"
- [ ] "Large file handling Git LFS"
- [ ] "Git submodules vs subtrees"

**Advanced Conflict Resolution:**

```bash
# Merge conflict tools
git config --global merge.tool kdiff3
git config --global merge.tool vscode
git mergetool --tool=vimdiff

# During conflicts
git status
git diff --ours filename
git diff --theirs filename
git checkout --ours filename
git checkout --theirs filename

# Git LFS
git lfs install
git lfs track "*.psd"
git add .gitattributes
git add large_file.psd
git commit -m "Add large file"
```

## 🔧 GIAI ĐOẠN 4: ADVANCED GIT TECHNIQUES (Tháng 5-6)

### Week 13: Git Internals

**Search Keywords để học:**

- [ ] "Git objects blob tree commit tag"
- [ ] "Git SHA-1 hash algorithm"
- [ ] "Git plumbing vs porcelain commands"
- [ ] "Git refs heads tags remotes"
- [ ] "Git packed objects and delta compression"
- [ ] "Git garbage collection and optimization"
- [ ] "Git repository structure .git folder"
- [ ] "Git index file format"

**Commands để practice:**

```bash
# Plumbing commands
git cat-file -t <hash>
git cat-file -p <hash>
git ls-tree HEAD
git rev-parse HEAD
git symbolic-ref HEAD

# Repository inspection
find .git/objects -type f
git count-objects -v
git fsck
git gc --aggressive

# Low-level operations
git hash-object filename
git update-index --add filename
git write-tree
```

### Week 14: Git Hooks & Automation

**Search Keywords để học:**

- [ ] "Git hooks tutorial pre-commit post-commit"
- [ ] "Client-side vs server-side Git hooks"
- [ ] "Git pre-push hook prevent bad commits"
- [ ] "Git commit-msg hook enforce standards"
- [ ] "Husky Git hooks for JavaScript projects"
- [ ] "Git hooks continuous integration"
- [ ] "Git hook scripts bash Python"
- [ ] "Git hooks security and validation"

**Hook Examples:**

```bash
# Hook locations
ls .git/hooks/

# Pre-commit hook example
#!/bin/sh
# .git/hooks/pre-commit
npm test
if [ $? -ne 0 ]; then
    echo "Tests must pass before commit!"
    exit 1
fi

# Commit-msg hook
#!/bin/sh
# .git/hooks/commit-msg
grep -q "^(feat|fix|docs|style|refactor|test|chore):" "$1"
if [ $? -ne 0 ]; then
    echo "Commit message must follow conventional commits format!"
    exit 1
fi

# Make hooks executable
chmod +x .git/hooks/pre-commit
```

### Week 15: Git Workflows for Teams

**Search Keywords để học:**

- [ ] "Git team workflows comparison"
- [ ] "Trunk-based development with Git"
- [ ] "Release management with Git tags"
- [ ] "Semantic versioning with Git"
- [ ] "Git monorepo vs multiple repositories"
- [ ] "Git strategies for microservices"
- [ ] "Git branching policies enforcement"
- [ ] "Code review best practices Git"

**Team Workflow Commands:**

```bash
# Release management
git tag -a v1.0.0 -m "Release version 1.0.0"
git tag -l "v*"
git push origin --tags
git checkout v1.0.0

# Semantic versioning
git describe --tags
git describe --tags --abbrev=0

# Protected branch workflow
git checkout -b feature/JIRA-123
git push -u origin feature/JIRA-123
# ... create pull request with required reviews ...

# Squash merge workflow
git checkout main
git merge --squash feature/JIRA-123
git commit -m "feat: add new feature (JIRA-123)"
```

### Week 16: Git Performance & Optimization

**Search Keywords để học:**

- [ ] "Git large repository optimization"
- [ ] "Git shallow clone for CI/CD"
- [ ] "Git partial clone and sparse checkout"
- [ ] "Git LFS large file storage"
- [ ] "Git bundle for offline transfer"
- [ ] "Git maintenance and housekeeping"
- [ ] "Git alternates share objects"
- [ ] "Git worktree multiple working directories"

**Performance Commands:**

```bash
# Shallow clones
git clone --depth 1 <url>
git clone --shallow-since="2 years ago" <url>

# Sparse checkout
git config core.sparseCheckout true
echo "src/" > .git/info/sparse-checkout
git read-tree -m -u HEAD

# Worktrees
git worktree add ../feature-branch feature-branch
git worktree list
git worktree remove ../feature-branch

# Bundle operations
git bundle create repo.bundle HEAD main
git clone repo.bundle repo-copy
```

## 🚀 GIAI ĐOẠN 5: GIT EXPERTISE (Tháng 7-8)

### Week 17: Advanced Git Commands

**Search Keywords để học:**

- [ ] "Git blame annotate code changes"
- [ ] "Git grep search in repository history"
- [ ] "Git log advanced filtering options"
- [ ] "Git shortlog contributor statistics"
- [ ] "Git notes add metadata to commits"
- [ ] "Git archive create project snapshots"
- [ ] "Git describe version from tags"
- [ ] "Git bisect automated bug hunting"

**Commands để practice:**

```bash
# Code investigation
git blame filename
git blame -L 10,20 filename
git annotate filename

# Searching
git grep "function_name"
git grep -n "TODO"
git log -S "search_term" --oneline
git log --grep="bug" --author="john"

# Statistics
git shortlog -s -n
git log --pretty=format:"%an" | sort | uniq -c | sort -nr

# Automated debugging
git bisect start
git bisect bad HEAD
git bisect good v1.0
git bisect run test_script.sh
```

### Week 18: Git Integration & Tools

**Search Keywords để học:**

- [ ] "Git IDE integration VSCode IntelliJ"
- [ ] "Git GUI tools comparison"
- [ ] "Git aliases and shortcuts"
- [ ] "Git and continuous integration"
- [ ] "Git with Docker containers"
- [ ] "Git server setup GitLab Gitea"
- [ ] "Git migration from SVN Perforce"
- [ ] "Git backup and disaster recovery"

**Integration Setup:**

```bash
# Git aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'

# Advanced aliases
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Git in CI/CD
# .github/workflows/main.yml
git fetch --prune --unshallow
git describe --tags --exact-match 2>/dev/null || git symbolic-ref -q --short HEAD
```

### Week 19: Git Security & Best Practices

**Search Keywords để học:**

- [ ] "Git security best practices"
- [ ] "Git commit signing GPG keys"
- [ ] "Git credential security management"
- [ ] "Git secrets detection prevention"
- [ ] "Git repository audit and compliance"
- [ ] "Git access control and permissions"
- [ ] "Git vulnerability assessment"
- [ ] "Git forensics and investigation"

**Security Commands:**

```bash
# GPG signing
gpg --gen-key
git config --global user.signingkey <key-id>
git config --global commit.gpgsign true
git commit -S -m "signed commit"
git log --show-signature

# Credential security
git config --global credential.helper manager
git credential-manager-core configure
git-secrets --install
git-secrets --register-aws

# Repository audit
git log --format=fuller
git log --all --full-history -- sensitive-file
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch sensitive-file' --prune-empty --tag-name-filter cat -- --all
```

### Week 20: Git Mastery Projects

**Search Keywords để học:**

- [ ] "Git workflow automation scripts"
- [ ] "Git repository analysis tools"
- [ ] "Custom Git commands development"
- [ ] "Git extension development"
- [ ] "Git server administration"
- [ ] "Git migration strategies"
- [ ] "Git training and mentoring"
- [ ] "Git troubleshooting complex issues"

**Master-level Projects:**

```bash
# Custom Git commands
# Create script: git-feature
#!/bin/bash
git checkout -b feature/$1
git push -u origin feature/$1

# Make executable and add to PATH
chmod +x git-feature
# Now can use: git feature new-awesome-feature

# Repository statistics script
#!/bin/bash
echo "Repository Statistics:"
echo "Total commits: $(git rev-list --all --count)"
echo "Contributors: $(git shortlog -s -n | wc -l)"
echo "Total files: $(git ls-files | wc -l)"
echo "Repository size: $(du -sh .git)"
```

## 📚 LEARNING RESOURCES BY CATEGORY

### 🎥 Video Courses

- "Git Complete: The Definitive Guide" - Udemy
- "Git Going Fast: One Hour Git Crash Course" - Udemy
- "Git and GitHub for Beginners - Crash Course" - freeCodeCamp
- "Advanced Git Tutorials" - Atlassian
- "Pro Git Concepts" - Pluralsight

### 📖 Books to Read

- "Pro Git" - Scott Chacon (Free online)
- "Git Pocket Guide" - Richard E. Silverman
- "Version Control with Git" - Jon Loeliger
- "Git Internals" - Scott Chacon
- "Learn Version Control with Git" - Tower

### 🛠️ Practice Platforms

- "Learn Git Branching" - Interactive visual tutorial
- "Git-it Desktop App" - Hands-on Git tutorial
- "Katacoda Git Scenarios" - Browser-based practice
- "GitHub Learning Lab" - Interactive courses
- "Oh My Git!" - Game to learn Git

### 🏅 Git Certifications & Assessments

- GitHub Certified Developer
- Atlassian Git Skills Assessment
- GitLab Certified Git Associate
- Stack Overflow Developer Survey Git Section

## ✅ DAILY PRACTICE CHECKLIST

### Morning Warm-up (15 mins)

- [ ] Practice 5 Git commands from memory
- [ ] Review Git status of current projects
- [ ] Read 1 Git tip or best practice
- [ ] Check Git configuration settings

### Active Practice (30-45 mins)

- [ ] Work on Git exercises from tutorial sites
- [ ] Practice advanced Git scenarios
- [ ] Experiment with new Git commands
- [ ] Contribute to open source projects

### Evening Review (15 mins)

- [ ] Document new Git commands learned
- [ ] Review Git aliases and shortcuts
- [ ] Plan next day's Git learning topics
- [ ] Update personal Git cheat sheet

## 🎯 GIT MASTERY MILESTONES

### Month 1-2: Foundation

- [ ] Understand Git fundamentals
- [ ] Master basic Git workflow
- [ ] Comfortable with branching and merging
- [ ] Can resolve simple conflicts

### Month 3-4: Intermediate

- [ ] Proficient with rebasing
- [ ] Understand remote repositories
- [ ] Can collaborate effectively
- [ ] Know multiple Git workflows

### Month 5-6: Advanced

- [ ] Understand Git internals
- [ ] Can write Git hooks
- [ ] Optimize Git performance
- [ ] Handle complex scenarios

### Month 7-8: Expert

- [ ] Master all Git commands
- [ ] Can teach Git to others
- [ ] Automate Git workflows
- [ ] Contribute to Git ecosystem

**Git Mastery Philosophy**: "Version control is not just about code, it's about understanding the evolution of your project!"

## 🚀 Quick Start Action Plan

### Day 1: Setup & First Steps

1. Install Git and configure basic settings
2. Create your first repository
3. Make your first commits
4. Connect to GitHub/GitLab

### Week 1 Goals

- [ ] Complete basic Git tutorial
- [ ] Set up Git aliases for efficiency
- [ ] Join Git community forums
- [ ] Start using Git for personal projects

### Month 1 Targets

- [ ] Master fundamental Git commands
- [ ] Complete first collaborative project
- [ ] Resolve first merge conflict
- [ ] Write first Git hook

**Remember**: Git mastery comes from daily practice and real-world application. Break things in a safe environment to learn how to fix them!
