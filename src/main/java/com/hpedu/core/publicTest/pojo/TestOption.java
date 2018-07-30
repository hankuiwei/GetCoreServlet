package com.hpedu.core.publicTest.pojo;

/**
 * 测试题-选择题 的选项及内容
 * @author Administrator
 *
 */
public class TestOption {
	private String id;
	private String testId;// 关联测试题id
	private String option;// 选项的值
	private String optionContent;// 选择题内容
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTestId() {
		return testId;
	}
	public void setTestId(String testId) {
		this.testId = testId;
	}
	public String getOption() {
		return option;
	}
	public void setOption(String option) {
		this.option = option;
	}
	public String getOptionContent() {
		return optionContent;
	}
	public void setOptionContent(String optionContent) {
		this.optionContent = optionContent;
	}

	
	
}
