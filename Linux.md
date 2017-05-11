# Linux �����Ӽ�

## ��������һ����վ
* [Downloading an Entire Web Site with wget](http://www.linuxjournal.com/content/downloading-entire-web-site-wget)
```bash
wget \
     --recursive \
     --no-clobber \
     --page-requisites \
     --html-extension \
     --convert-links \
     --restrict-file-names=windows \
     --domains website.org \
     --no-parent \
         www.website.org/tutorials/html/
```


## ȥ����֪pdf������߱���
* [HowTo: Linux Remove a PDF File Password Using Command Line Options](https://www.cyberciti.biz/faq/removing-password-from-pdf-on-linux/)
```bash
qpdf --password=YOURPASSWORD-HERE --decrypt input.pdf output.pdf

```

