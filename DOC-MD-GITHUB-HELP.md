
# Assistance in Markdown format & Github Actions in a documentation.

## Markdown

### Headings

To create a heading, add one to six <kbd>#</kbd> symbols before your heading text. The number of <kbd>#</kbd> you use will determine the hierarchy level and typeface size of the heading.

```
# A first-level heading
## A second-level heading
### A third-level heading
```
> Third level heading is not the end , you can insert a fourth to **n<sup>th</sup>** level heading.

#### Basic formatting


    - **Bold** - ``**Bold**``
    - _Italics_ - ``_Italics_``

#### Lists

**Ordered list**

In the ordered list, It does not required to be countinous number in the list. The format is that a number followed by ``.``

For example
1. One
1. Two
3. Three
1. Four

```md 
1. One
1. Two
3. Three
1. Four
```

**Unordered List**

In the unordered list, the list will start by ``-`` 

For example
 - One
 - Two
 - Three

```md 
 - One
 - Two
 - Three
```

#### Quoting text

You can quote text with a <kbd>></kbd>.

```markdown
Text that is not a quote

> Text that is a quote
``` 
#### Links

For Linking a heading in the same markdown file. Reference the ``[Link text](Link header or file)``. 

 
If a heading is referenced it should start with ``#`` with text in **all lowercase** placed in between the ``()`` without any spaces. If spaces are present in the referred heading, spaces should be replaced with ``-``

for example:

[Basic formatting](#basic-formatting) 

```md
  [Basic formatting](#basic-formatting)
```
    

## Paragraphs

You can create a new paragraph by leaving a blank line between lines of text.

## Footnotes

You can add footnotes to your content by using this bracket syntax:

```text
Here is a simple footnote[^1].

A footnote can also have multiple lines[^2].

[^1]: My reference.
[^2]: To add line breaks within a footnote, prefix new lines with 2 spaces.
  This is a second line.
```

## Work Flows in the projects using Github 

### Initial Project Repo

First create a new repositary with ``readme.md`` file

### Issues 

If you want to add an add/edit/deletion of code in your repo 
1. Create an issue with a short title as moderate as possible, **dont add a long line of text in the title**.
      > A list can also be created if know a list of process involved in resolving the issue.
1. After the creation the branch, the reference number will be issued in which branch naming will be generated automatically.
1. In the issue page, you can create a branch for the issue.
1. Then, Checkout the branch and you can add/edit/delete to work through the issue.
1. Upon submitting the changes please add ``#Reference number`` before the commit message which will automatically pin the message in the issue.
For example, if ``1`` is reference number, then branch will starts with ``1-xxxxx`` and in commit message, type as ``#1 xx xx xxx``
1. After committing the code, type git push in the terminal to push the code to **Github**


### Pull Request

The committed code always should be merged with main branch with a pull request. Every pull request can have review (who review the code) and assigner (who can assign the permissions for pull request).

Only after the approval of the reviewer the code can be merged.


> The reference number generated is countious for every action in the project. It will not generate a specific number for an issue and same number for a pull request.



### Tagging the main branch 

For tagging details check readme.md

After merging the branch to the main branch, you have to tag the main branch.
1. First, Type ``git pull`` to sync the code with local repo.
2. Then, Type ``git tag x.x.x`` 
3. Then, Type ``git push --tags`` to push the tag details to **Github**
> The tags details will not be pushed into github repo unless mentioned explicitly as mentioned above