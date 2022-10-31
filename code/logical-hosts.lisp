(in-package #:trivial-pathname)

(defun list-all-logical-hosts ()
  #+abcl
  (loop for key being the hash-key in system:*logical-pathname-translations*
        collect key)
  #+ccl
  (mapcar #'car ccl::%logical-host-translations%)
  #+clasp
  (ext:list-all-logical-hosts)
  #+cmucl
  (loop for key being the hash-key in lisp::*logical-hosts*
        collect key)
  #+ecl
  (mapcar #'car (sys:pathname-translations))
  #+mezzano
  (mezzano.file-system:list-all-hosts)
  #+sbcl
  (map 'list #'sb-impl::logical-host-name sb-impl::*logical-hosts*))

(defun logical-host-p (host)
  #+abcl
  (system:logical-host-p host)
  #+ccl
  (ccl::logical-host-p host)
  #+clasp
  (ext:logical-host-p host)
  #+cmucl
  (and (lisp::find-logical-host host nil) t)
  #+ecl
  (and (sys:pathname-translations host) t)
  #+mezzano
  (and (mezzano.file-system:find-host host nil) t)
  #+sbcl
  (and (sb-impl::find-logical-host host nil) t)
  #-(or abcl ccl cmucl mezzano sbcl)
  (typep (make-pathname :host host) 'logical-pathname))
