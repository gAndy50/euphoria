include file.e
include unittest.e

set_test_module_name("file.e")

-- TODO: add more tests

object data, tmp

data = read_lines("file.txt")
test_equal("read_lines() #1", 9, length(data))
test_equal("read_lines() #2", 42, length(data[1]))
test_equal("read_lines() #3", "This is a file used for unit tests. Please", data[1])
test_equal("read_lines() #4", "Thank You!", data[9])

tmp = open("file.txt", "r")
data = read_lines(tmp)
test_equal("read_lines() #5", 9, length(data))
test_equal("read_lines() #6", 42, length(data[1]))
test_equal("read_lines() #7", "This is a file used for unit tests. Please", data[1])
test_equal("read_lines() #8", "Thank You!", data[9])
close(tmp)

data = read_file("file.txt")
test_equal("read_file() #1", 253, length(data))
test_equal("read_file() #2", "alter this file", data[51..65])

tmp = open("file.txt", "r")
test_equal("where() #1", 0, where(tmp))
data = read_file(tmp)
test_equal("read_file() #1", 253, length(data))
test_equal("read_file() #2", "alter this file", data[51..65])
test_equal("where() #2", 253, where(tmp))
close(tmp)

sequence fullname, pname, fname, fext
integer sep

if platform() = DOS32 or platform() = WIN32 then
    fullname = "C:\\EUPHORIA\\DOCS\\readme.txt"
    pname = "C:\\EUPHORIA\\DOCS"
    sep = '\\'
else
    fullname = "/opt/euphoria/docs/readme.txt"
    pname = "/opt/euphoria/docs"
    sep = '/'
end if

fname = "readme"
fext = "txt"

test_equal("pathinfo() fully qualified path", {pname, fname, fext},
    pathinfo(fullname))
test_equal("pathinfo() no extension", {pname, fname, ""},
    pathinfo(pname & PATHSEP & fname))
test_equal("pathinfo() no dir", {"", fname, fext}, pathinfo(fname & "." & fext))
test_equal("pathinfo() no dir, no extension", {"", fname, ""}, pathinfo("readme"))

test_equal("dirname() full path", pname, dirname(fullname))
test_equal("dirname() filename only", "", dirname(fname & "." & fext))

test_equal("filename() full path", fname & "." & fext, filename(fullname))
test_equal("filename() filename only", fname & "." & fext, filename(fname & "." & fext))
test_equal("filename() filename no extension", fname, filename(fname))

test_equal("fileext() full path", fext, fileext(fullname))
test_equal("fileext() filename only", fext, fileext(fullname))
test_equal("fileext() filename no extension", "", fileext(fname))

test_equal("PATHSEP", sep, PATHSEP)
