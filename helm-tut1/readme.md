## Helm Help

‘helm create foo’ will create a directory structure that looks something like this:

foo/
\|
\|\- \.helmignore \# Contains patterns to ignore when packaging Helm charts\.
\|
\|\- Chart\.yaml \# Information about your chart
\|
\|\- values\.yaml \# The default values for your templates
\|
\|\- charts/ \# Charts that this chart depends on
\|
\|\- templates/ \# The template files
\|
\|\- templates/tests/ \# The test files

[https://v2.helm.sh/docs/helm/#helm-rep-list](https://v2.helm.sh/docs/helm/#helm-rep-list)
<br>
```
helm delete [flags] RELEASE-NAME [...]
```
<br>
```
helm dependency build [flags] CHART
```
<br>
```
helm dependency list [flags] CHART
```
<br>
```
helm dependency update [flags] CHART
```
<br>
```
helm fetch [flags] [chart URL | repo/chartname] [...]
```
<br>
```
helm get [flags] RELEASE-NAME
```
<br>
```
helm get hooks [flags] RELEASE-NAME
```
<br>
```
helm get manifest [flags] RELEASE-NAME
```