(asdf:defsystem #:trivial-pathname
  :description ""
  :author "Tarn W. Burton"
  :license "MIT"
  :version "1.0.0"
  :homepage "https://yitzchak.github.io/trivial-pathname/"
  :bug-tracker "https://github.com/yitzchak/trivial-pathname/issues"
  :components ((:module code
                :serial t
                :components ((:file "packages")
                             (:file "logical-hosts")))))
