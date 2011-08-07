## Resume, be Template

When I am not too busy, say, in-between jobs with no prospects, I like to keep my programming sharp by doing stupid projects.

This is one of them.

#### How does this work?

Files in the `src/` directory contain the templates, with are processed by Template-Toolkit, a Perl templating module. The actual resume *content* lives in the `resume.yaml` file.

The make-ish shell script, `make.sh` contains functions for generating the templates and processing the resulting files into other formats. Another perl module, Template-Toolkit-Simple, provides the bin script `tt-render` that uses YAML-XS and processes the templates with that data.

Elementary.
