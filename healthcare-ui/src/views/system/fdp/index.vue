<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="协议编号" prop="orderCode">
        <el-input
          v-model="queryParams.orderCode"
          placeholder="请输入协议编号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="甲方姓名" prop="userName">
        <el-input
          v-model="queryParams.userName"
          placeholder="请输入甲方姓名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="签约日期" prop="signDate">
        <el-date-picker clearable
          v-model="queryParams.signDate"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择签约日期">
        </el-date-picker>
      </el-form-item>

      <el-form-item label="销售姓名" prop="salesName">
        <el-input
          v-model="queryParams.salesName"
          placeholder="请输入销售姓名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="产妇姓名" prop="motherName">
        <el-input
          v-model="queryParams.motherName"
          placeholder="请输入产妇姓名"
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
          v-hasPermi="['system:fdp:add']"
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
          v-hasPermi="['system:fdp:edit']"
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
          v-hasPermi="['system:fdp:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:fdp:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="fdpList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="协议编号" align="center" prop="orderCode" />
      <el-table-column label="电子签约号" align="center" prop="proCode" />
      <el-table-column label="签约日期" align="center" prop="signDate">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.signDate, '{y}-{m}-{d}') }}</br>{{ parseTime(scope.row.signDate, '{h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
	  <el-table-column label="支付日期" align="center" prop="payDate">
	      <template slot-scope="scope">
	        <span>{{ parseTime(scope.row.payDate, '{y}-{m}-{d}') }}</br>{{ parseTime(scope.row.payDate, '{h}:{i}:{s}') }}</span>
	      </template>
	    </el-table-column>
      <el-table-column label="甲方姓名" align="center" prop="userName" />
	  <el-table-column label="甲方电话" align="center" prop="phonenumber" />
      <el-table-column label="销售价格" align="center" prop="priceOut" />
      <el-table-column label="产妇姓名" align="center" prop="motherName" />
	  <el-table-column label="预产医院" align="center" prop="hospitalName" />
	  <el-table-column label="预产期" align="center" prop="dueDate" />
	  <el-table-column label="协议状态" align="center" prop="statusTxt" />
	  <el-table-column label="销售" align="center" prop="salesName" />
	  <el-table-column label="同步状态" align="center" prop="syncFlag" />
	  <el-table-column label="同步结果" align="center" prop="remark" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:fdp:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:fdp:remove']"
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

    <!-- 添加或修改冻干粉订单对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="电子签约号" prop="proCode">
          <el-input v-model="form.proCode" placeholder="请输入电子签约号" />
        </el-form-item>
        <el-form-item label="微信用户ID" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入微信用户ID" />
        </el-form-item>
        <el-form-item label="签约日期" prop="signDate">
          <el-date-picker clearable
            v-model="form.signDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择签约日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="销售价格" prop="priceOut">
          <el-input v-model="form.priceOut" placeholder="请输入销售价格" />
        </el-form-item>
        <el-form-item label="产妇ID" prop="motherId">
          <el-input v-model="form.motherId" placeholder="请输入产妇ID" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
		<el-button @click="sync" v-if="this.form.syncFlag!= 1">同 步</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listFdp, getFdp, delFdp, addFdp, updateFdp, syncFdp } from "@/api/system/fdp";

export default {
  name: "Fdp",
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
      // 冻干粉订单表格数据
      fdpList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        recordStatus: null,
        proCode: null,
        proStatus: null,
        orderStatus: null,
        userId: null,
        signDate: null,
        priceIn: null,
        taxIn: null,
        priceOut: null,
        taxOut: null,
        priceBack: null,
        payDate: null,
        payType: null,
        isCheckFrom: null,
        motherId: null,
        cMemo: null,
        getFlag: null,
        getHId: null,
        getTpDate: null,
        getIsPass: null,
        getReportDate: null,
        isSubmitWith: null,
        submitDateWith: null,
        submitNumber: null,
        submitUnit: null,
        submitUnitPer: null,
        submitUnitSs: null,
        submitDatePlan: null,
        submitUidPlan: null,
        submitRequirePlan: null,
        submitMemoPlan: null,
        submitDate: null,
        submitUid: null,
        submitMemo: null,
        submitType: null,
        backApplyFlag: null,
        backDateApply: null,
        backMemoApply: null,
        backProFlag: null,
        backDateCancel: null,
        backDate: null,
        uploadReceipt: null,
        receiptAddr: null,
        receiptUid: null,
        receiptTime: null,
        uploadInvoice: null,
        invoiceAddr: null,
        invoiceUid: null,
        invoiceTime: null,
        tooutDate: null,
        tooutMemo: null,
        tooutExpid: null,
        tooutExpcode: null,
        isSpecial: null,
        getNumber: null,
        getInfomemo: null,
        testSuccessDate: null,
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
    /** 查询冻干粉订单列表 */
    getList() {
      this.loading = true;
      listFdp(this.queryParams).then(response => {
        this.fdpList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
	sync() {
		if (this.form.id != null) {
	        syncFdp(this.form.id).then(response => {
	          this.$modal.msgSuccess("同步完成");
	          this.open = false;
	          this.getList();
			});
	    }
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        recordStatus: null,
        proCode: null,
        proStatus: null,
        orderStatus: null,
        userId: null,
        signDate: null,
        priceIn: null,
        taxIn: null,
        priceOut: null,
        taxOut: null,
        priceBack: null,
        payDate: null,
        payType: null,
        isCheckFrom: null,
        motherId: null,
        cMemo: null,
        getFlag: null,
        getHId: null,
        getTpDate: null,
        getIsPass: null,
        getReportDate: null,
        isSubmitWith: null,
        submitDateWith: null,
        submitNumber: null,
        submitUnit: null,
        submitUnitPer: null,
        submitUnitSs: null,
        submitDatePlan: null,
        submitUidPlan: null,
        submitRequirePlan: null,
        submitMemoPlan: null,
        submitDate: null,
        submitUid: null,
        submitMemo: null,
        submitType: null,
        backApplyFlag: null,
        backDateApply: null,
        backMemoApply: null,
        backProFlag: null,
        backDateCancel: null,
        backDate: null,
        uploadReceipt: null,
        receiptAddr: null,
        receiptUid: null,
        receiptTime: null,
        uploadInvoice: null,
        invoiceAddr: null,
        invoiceUid: null,
        invoiceTime: null,
        tooutDate: null,
        tooutMemo: null,
        tooutExpid: null,
        tooutExpcode: null,
        isSpecial: null,
        getNumber: null,
        getInfomemo: null,
        testSuccessDate: null,
        createBy: null,
        createTime: null
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
      this.title = "添加冻干粉订单";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getFdp(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改冻干粉订单";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateFdp(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addFdp(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除冻干粉订单编号为"' + ids + '"的数据项？').then(function() {
        return delFdp(ids);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/fdp/export', {
        ...this.queryParams
      }, `fdp_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
