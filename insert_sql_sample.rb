# �{�v���O�����̈Ӑ}
# �i�O��FDB��Oracle�j
# �w�肵��SQL�Ńe�[�u������f�[�^�𒊏o���A
# ���̃f�[�^�����ɁA�C���T�[�gSQL���𐶐����܂��B
# �܂��A�����������ʂ��uinset_�e�[�u����.sql�v�֏o�͂��܂��B

# �g�����C�u�����̃��[�h
require 'oci8'

# �e�[�u����
table = "MY_TABLE"

# SQL
select_sql = 'select * from ' << table << ' where condition_col = \'GO\''

# �o��
f2 = open('insert_' << table << '.sql', "w")

# �C���T�[�g���̃w�b�_
insert_header  = 'insert into ' << table << ' values ('

#�I�u�W�F�N�g�̍쐬 OCI8.new("���[�U��","�p�X���[�h","SID")
my_ora = OCI8.new("username", "password","SID")

cloTypes = my_ora.describe_table(table).columns

# log
cloTypes.each do |c|
	puts c.type_string
	puts c.name
end


#sql�����s
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

#�b����ʂ������Ȃ��悤�ɁB��ʃR�s�[����������B
# sleep(30)


