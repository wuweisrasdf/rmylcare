<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="甲方ID" prop="userId">
        <el-input
          v-model="queryParams.userId"
          placeholder="请输入甲方ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="甲方与产妇关系" prop="motherRelation">
        <el-input
          v-model="queryParams.motherRelation"
          placeholder="请输入甲方与产妇关系(1-本人、2-丈夫)"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="姓名" prop="motherName">
        <el-input
          v-model="queryParams.motherName"
          placeholder="请输入姓名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="邮箱" prop="email">
        <el-input
          v-model="queryParams.email"
          placeholder="请输入邮箱"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="手机号" prop="phonenumber">
        <el-input
          v-model="queryParams.phonenumber"
          placeholder="请输入手机号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="证件号码" prop="idCode">
        <el-input
          v-model="queryParams.idCode"
          placeholder="请输入证件号码"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="预产医院" prop="hospitalName">
        <el-input
          v-model="queryParams.hospitalName"
          placeholder="请输入预产医院"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="预产期" prop="dueDate">
        <el-date-picker clearable
          v-model="queryParams.dueDate"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择预产期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="地址" prop="address">
        <el-input
          v-model="queryParams.address"
          placeholder="请输入地址"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:mother:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:mother:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:mother:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:mother:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="motherList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键" align="center" prop="id" />
      <el-table-column label="甲方ID" align="center" prop="userId" />
      <el-table-column label="甲方与产妇关系(1-本人、2-丈夫)" align="center" prop="motherRelation" />
      <el-table-column label="姓名" align="center" prop="motherName" />
      <el-table-column label="邮箱" align="center" prop="email" />
      <el-table-column label="手机号" align="center" prop="phonenumber" />
      <el-table-column label="证件类型(1-身份证、2-护照、3-永久居留身份证、4-台湾来往大陆通行证、5-香港来往大陆通行证、6-澳门来往大陆通行证、10-其它)" align="center" prop="idType" />
      <el-table-column label="证件号码" align="center" prop="idCode" />
      <el-table-column label="预产医院" align="center" prop="hospitalName" />
      <el-table-column label="预产期" align="center" prop="dueDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.dueDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="地址" align="center" prop="address" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:mother:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:mother:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改产妇信息对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="甲方ID" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入甲方ID" />
        </el-form-item>
        <el-form-item label="甲方与产妇关系" prop="motherRelation">
			<el-select v-model="form.motherRelation" placeholder="请选择关系">
                <el-option
                  v-for="dict in dict.type.hm_mother_relation"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                ></el-option>
              </el-select>
        </el-form-item>
        <el-form-item label="姓名" prop="motherName">
          <el-input v-model="form.motherName" placeholder="请输入姓名" />
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
          <el-input v-model="form.email" placeholder="请输入邮箱" />
        </el-form-item>
        <el-form-item label="手机号" prop="phonenumber">
          <el-input v-model="form.phonenumber" placeholder="请输入手机号" />
        </el-form-item>
		
		
        <el-form-item label="证件类别">
          <el-select v-model="form.idType" placeholder="请选择类别">
            <el-option
              v-for="dict in dict.type.hm_mother_id_type"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
		
        <el-form-item label="证件号码" prop="idCode">
          <el-input v-model="form.idCode" placeholder="请输入证件号码" />
        </el-form-item>
        <el-form-item label="预产医院" prop="hospitalName">
          <el-input v-model="form.hospitalName" placeholder="请输入预产医院" />
        </el-form-item>
        <el-form-item label="预产期" prop="dueDate">
          <el-date-picker clearable
            v-model="form.dueDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择预产期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="地址" prop="address">
          <el-input v-model="form.address" placeholder="请输入地址" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listMother, getMother, delMother, addMother, updateMother } from "@/api/system/mother";

export default {
  name: "Mother",
  dicts: ['hm_mother_relation','hm_mother_id_type'],
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 产妇信息表格数据
      motherList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userId: null,
        motherRelation: null,
        motherName: null,
        email: null,
        phonenumber: null,
        idType: null,
        idCode: null,
        hospitalName: null,
        dueDate: null,
        address: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询产妇信息列表 */
    getList() {
      this.loading = true;
      listMother(this.queryParams).then(response => {
        this.motherList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        userId: null,
        motherRelation: null,
        motherName: null,
        email: null,
        phonenumber: null,
        idType: null,
        idCode: null,
        hospitalName: null,
        dueDate: null,
        address: null
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加产妇信息";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getMother(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改产妇信息";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateMother(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addMother(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids;
      this.$modal.confirm('是否确认删除产妇信息编号为"' + ids + '"的数据项？').then(function() {
        return delMother(ids);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/mother/export', {
        ...this.queryParams
      }, `mother_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
