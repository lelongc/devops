# 3)Viết chương trình mã hóa 2 chuỗi và cho biết kết quả sau khi mã hóa
s1="ĐẠI HỌC CÔNG NGHIỆP TP HỒ CHÍ MINH"
s2='Khoa Công nghệ thông tin'
s1_encoded = s1.encode('utf-8')
s2_encoded = s2.encode('utf-8')
print(s1_encoded)
print(s2_encoded)

# 4)Cho 
s1=b'Vi\xe1\xbb\x87t Nam m\xe1\xba\xbfn y\xc3\xaau' ; 
s2= b'ng\xc6\xb0\xe1\xbb\x9di Vi\xe1\xbb\x87t d\xc3\xb9ng h\xc3\xa0ng Vi\xe1\xbb\x87t'
# a)Viết lệnh giải mã chuỗi s1 và s2 và cho biết kết quả.
s1_decoded = s1.decode('utf-8')
s2_decoded = s2.decode('utf-8')
print(s1_decoded)
print(s2_decoded)

# b)Cho biết kích thước của chuỗi s1 và s2
print(len(s1))
print(len(s2))
# c)Cho biết kết quả của lệnh print(list(s1)) và print(list(s2))

print(list(s1))
print(list(s2))
# 5)cho chuỗi text = "記者 鄭啟源 羅智堅" ; 
# a)Kết quả mã hóa của chuỗi text
text = "記者 鄭啟源 羅智堅"
text_encoded = text.encode('utf-8')
print(text_encoded)

# b)Cho biết kết quả của 2 lệnh sau:
# print(len(text))
# print(len(text.encode('utf-8')))


