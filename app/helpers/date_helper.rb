module DateHelper
	def local_date(datetime, show_year: true)
		show_year ? "#{datetime.year}년 #{datetime.month}월 #{datetime.day}일" : "#{datetime.month}월 #{datetime.day}일"
	end
end