## Resume, be Template

When I am not too busy, say, in-between jobs, I like to keep my programming sharp by automating things.

This is one of them.

#### How does this work?

The resume data lives in `resume.yaml` which is then processed by the python script `render_jinja.py` using the [Jinja2](http://jinja.pocoo.org/) templates.

To build all the templates, simply type `make all` or the files of choice; resume.pdf, resume.html, or resume.txt

Prerequisites:

- Jinja2 `pip install jinja`
- Latex (for the tex/ps/pdf files)

