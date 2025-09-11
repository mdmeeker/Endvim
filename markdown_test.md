# Markdown Rendering Test

This is a comprehensive markdown test file to verify that all formatting elements render correctly.

## Headers

### Level 3 Header
#### Level 4 Header
##### Level 5 Header
###### Level 6 Header

## Text Formatting

**Bold text** and __also bold__

*Italic text* and _also italic_

***Bold and italic*** and ___also bold and italic___

~~Strikethrough text~~

`Inline code` formatting

## Lists

### Unordered Lists
- First item
- Second item
  - Nested item
  - Another nested item
    - Deep nested item
- Third item

### Ordered Lists
1. First numbered item
2. Second numbered item
   1. Nested numbered item
   2. Another nested item
3. Third numbered item

### Task Lists
- [x] Completed task
- [ ] Incomplete task
- [x] Another completed task

## Links and Images

[External link to Google](https://www.google.com)

[Internal link](#text-formatting)

## Code Blocks

### Inline Code
Here's some `inline code` in a sentence.

### Code Blocks with Syntax Highlighting

```python
def hello_world():
    """A simple Python function."""
    print("Hello, World!")
    return True

# This is a comment
x = [1, 2, 3, 4, 5]
y = sum(x)
```

```javascript
function greetUser(name) {
    // JavaScript example
    const greeting = `Hello, ${name}!`;
    console.log(greeting);
    return greeting;
}

const users = ['Alice', 'Bob', 'Charlie'];
users.forEach(user => greetUser(user));
```

```bash
# Bash commands
ls -la
cd /home/user
grep -r "pattern" .
```

## Blockquotes

> This is a simple blockquote.
> It can span multiple lines.

> This is a blockquote with **bold** and *italic* text.
> 
> > This is a nested blockquote.
> > It's indented further.

## Tables

| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| Row 1, Col 1 | Row 1, Col 2 | Row 1, Col 3 |
| Row 2, Col 1 | Row 2, Col 2 | Row 2, Col 3 |
| Row 3, Col 1 | Row 3, Col 2 | Row 3, Col 3 |

### Table with Alignment

| Left Aligned | Center Aligned | Right Aligned |
|:-------------|:--------------:|--------------:|
| Left         | Center         | Right         |
| Text         | Text           | Text          |
| More         | More           | More          |

## Horizontal Rules

---

***

___

## Mathematical Expressions (if supported)

Inline math: $E = mc^2$

Block math:
$$
\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}
$$

## Special Characters and Escaping

Here are some special characters: & < > " ' 

Escaped characters: \* \_ \` \# \\ \[ \]

## Emojis (if supported)

:smile: :heart: :rocket: :computer: :books:

## HTML Elements (if supported)

<details>
<summary>Click to expand</summary>

This content is hidden by default and can be expanded.

</details>

<mark>Highlighted text</mark>

<kbd>Ctrl</kbd> + <kbd>C</kbd>

## Line Breaks and Spacing

This is a paragraph with a line break.  
This line has two spaces at the end of the previous line.

This is a new paragraph with proper spacing.

## Footnotes (if supported)

Here's a sentence with a footnote[^1].

[^1]: This is the footnote content.

## Definition Lists (if supported)

Term 1
: Definition for term 1

Term 2
: Definition for term 2
: Another definition for term 2

---

*This markdown test file covers most common markdown features. Check how each section renders in your markdown viewer!*
