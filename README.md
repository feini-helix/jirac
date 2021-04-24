# jirac
A tiny tool to help creating Jiras.

In some condition, we need create a lot of Jira stories as placeholder and just put its title there, so that we can fill in other fields later.

This tool is helpful for such condition.

## Usage

### Update .jirac file
```
readonly BaseURL=https://<company>.atlassian.net
readonly Email=<email>
readonly APIToken=<token>
readonly Template="$(cat <<EOF
{
  "fields":{
    "project":{
      "key": "<project>"
    },
    "summary":  "TITLE",
    "description": {
      "type": "doc",
      "version": 1,
      "content": [
        {
          "type": "paragraph",
          "content": [
            {
              "type": "text",
              "text": ""
            }
          ]
        }
      ]
    },
    "issuetype": {"name": "Story"}
  }
}
EOF
)"
```

Replace `BaseURL`, `Email`, `APIToken`, `project` with the real one in your Jira.

### Create a multiple lines file, each line is a title of new Jira story

```
$ cat input.txt
First Jira story
Second Jira Story
# Skip me
Third Jira Story
```

if a line starting with '#', it will be skipped

### Run `jirac.sh` to create jiras

```bash
cat input.txt | bash ./jirac.sh
```


## Other useful jira command tool
 - [go-jira](https://github.com/go-jira/jira)

### Add lable
```bash
go-jira labels set <ISSUE> <LABEL>
```

### Add Epic for issue
```bash
go-jira epic add <EPIC> <ISSUE>
```

### List all issues in Epic
```bash
go-jira epic list <EPIC>
```
