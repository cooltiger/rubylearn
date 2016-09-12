# 本プログラムの意図
# （前提：DBがOracle）
# 指定したSQLでテーブルからデータを抽出し、
# そのデータを元に、インサートSQL文を生成します。
# また、生成した結果を「inset_テーブル名.sql」へ出力します。

# 拡張ライブラリのロード
require 'oci8'

# テーブル名
table = "MY_TABLE"

# SQL
select_sql = 'select * from ' << table << ' where condition_col = \'GO\''

# 出力
f2 = open('insert_' << table << '.sql', "w")

# インサート文のヘッダ
insert_header  = 'insert into ' << table << ' values ('

#オブジェクトの作成 OCI8.new("ユーザ名","パスワード","SID")
my_ora = OCI8.new("username", "password","SID")

cloTypes = my_ora.describe_table(table).columns

# log
cloTypes.each do |c|
	puts c.type_string
	puts c.name
end


#sql文発行
puts select_sql
my_ora.exec(select_sql) do |r|
	data = ""
	r.each_with_index  do |c, i|
		t = cloTypes[i].type_string

		if t.include?("CHAR")  then
			data <<  "\'%s\'," % [c] 
		elsif t.include?("NUMBER") then
			if c.instance_of? BigDecimal then
				data << c.to_s("F") << ','
			elsif
				data << c.to_s << ','
			end
			
		elsif t.include?("DATE")   then
			data <<  "\'%s\'," % [c.strftime("%Y/%m/%d %H:%M:%S")] 
		else
			data <<  "\'%s\'," % [c] 
		end
	end	
	
    f2.puts insert_header + data[0..-2] + ')'
    puts insert_header + data[0..-2] + ')'
end

#暫く画面が消えないように。画面コピーしたいから。
# sleep(30)


