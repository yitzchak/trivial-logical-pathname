(in-package #:trivial-pathname)

(defun list-all-logical-hosts ()
  "list-all-logical-hosts returns a fresh list of all logical hosts."
  #+(or abcl clisp cmucl)
  (loop for key being the hash-key in #+abcl system:*logical-pathname-translations*
                                      #+clisp sys::*logical-pathname-translations*
                                      #+cmucl lisp::*logical-hosts*
        collect key)
  #+ccl
  (mapcar #'car ccl::%logical-host-translations%)
  #+clasp
  (ext:list-all-logical-hosts)
  #+ecl
  (mapcar #'car (sys:pathname-translations))
  #+mezzano
  (mezzano.file-system:list-all-hosts)
  #+sbcl
  (map 'list #'sb-impl::logical-host-name sb-impl::*logical-hosts*))

(defun logical-host-p (host)
  "Returns true if host is a logical host; otherwise returns false."
  #+abcl
  (system:logical-host-p host)
  #+ccl
  (ccl::logical-host-p host)
  #+clasp
  (ext:logical-host-p host)
  #+clisp
  (and (simple-string-p host)
       (gethash host sys::*logical-pathname-translations*)
       t)
  #+cmucl
  (and (lisp::find-logical-host host nil) t)
  #+ecl
  (and (sys:pathname-translations host) t)
  #+mezzano
  (and (mezzano.file-system:find-host host nil) t)
  #+sbcl
  (and (sb-impl::find-logical-host host nil) t)
  #-(or abcl ccl clisp clasp cmucl ecl mezzano sbcl)
  (typep (make-pathname :host host) 'logical-pathname))
