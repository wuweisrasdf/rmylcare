<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="协议编号" prop="firstName">
        <el-input
          v-model="queryParams.orderCode"
          placeholder="请输入协议编号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
	  <el-form-item >
        <el-radio-group v-model="queryParams.checkStep" >
				<el-radio :label="1" @change="getList4Status">待提交</el-radio>
			    <el-radio :label="2" @change="getList4Status">待审核</el-radio>
			    <el-radio :label="3" @change="getList4Status">已退款</el-radio>
        </el-radio-group>
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
          v-hasPermi="['system:refund:add']"
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
          v-hasPermi="['system:refund:edit']"
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
          v-hasPermi="['system:refund:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:refund:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="refundList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="退款单号" align="center" prop="syncId" width="120" />
      <el-table-column label="协议编号" align="center" prop="orderCode" width="120"/>
      <el-table-column label="甲方姓名" align="center" prop="firstName" />
	  <el-table-column label="微信流水号" align="center" prop="transactionId" />
      <el-table-column label="收款金额" align="center" prop="amount" />
      <el-table-column label="退款金额" align="center" prop="refund" />
      <el-table-column label="提交人" align="center" prop="user1Name" />
	  <el-table-column label="提交时间" align="center" prop="commit1Date" width="180">
	      <template slot-scope="scope">
	        <span>{{ parseTime(scope.row.commit1Date, '{y}-{m}-{d}') }}</br>{{ parseTime(scope.row.commit1Date, '{h}:{i}:{s}') }}</span>
	      </template>
	    </el-table-column>
	  <el-table-column label="审核人" align="center" prop="user2Name" />
      <el-table-column label="审核时间" align="center" prop="commit2Date" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.commit2Date, '{y}-{m}-{d}') }}</br>{{ parseTime(scope.row.commit2Date, '{h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="微信支付信息" align="center" prop="wxResult" />
      <el-table-column label="同步标志" align="center" prop="syncFlag" />
      <el-table-column label="备注" align="center" prop="remark" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button v-if="scope.row.user1Id == 0 && viewCheckButton(1)"
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleCheck(scope.row,1)"
            v-hasPermi="['system:refund:edit']"
          >出纳审核</el-button>
		  <el-button v-if="scope.row.user1Id != 0 && scope.row.wxStatus != 1 && viewCheckButton(2)"
	          size="mini"
	          type="text"
	          icon="el-icon-edit"
	          @click="handleCheck(scope.row,2)"
	          v-hasPermi="['system:refund:edit']"
	        >会计审核</el-button>
          <el-button v-if="!viewCheckButton(0)"
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:refund:edit']"
          >修改</el-button>
          <el-button v-if="!viewCheckButton(0)"
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:refund:remove']"
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

    <!-- 添加或修改退款单对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="业务系统ID" prop="syncId">
          <el-input v-model="form.syncId" placeholder="请输入业务系统ID" />
        </el-form-item>
        <el-form-item label="合同ID" prop="orderId">
          <el-input v-model="form.orderId" placeholder="请输入合同ID" />
        </el-form-item>
        <el-form-item label="甲方姓名" prop="firstName">
          <el-input v-model="form.firstName" placeholder="请输入甲方姓名" />
        </el-form-item>
        <el-form-item label="收款金额" prop="amount">
          <el-input v-model="form.amount" placeholder="请输入收款金额" />
        </el-form-item>
        <el-form-item label="退款金额" prop="refund">
          <el-input v-model="form.refund" placeholder="请输入退款金额" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
		<el-button @click="sync" v-if="this.form.wxStatus==1 && this.form.syncFlag!= 1">同 步</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listRefund, getRefund, delRefund, addRefund, updateRefund, checkRefund, syncRefund } from "@/api/system/refund";

export default {
  name: "Refund",
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
      // 退款单表格数据
      refundList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        syncId: null,
        orderId: null,
		orderCode: null,
        firstName: null,
        amount: null,
        refund: null,
        user1Id: null,
		user1Name: null,
        user2Id: null,
		user2Name: null,
        commit1Date: null,
        commit2Date: null,
        wxStatus: null,
        wxResult: null,
        syncFlag: null,
		checkStep: null,
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
    /** 查询退款单列表 */
    getList() {
      this.loading = true;
      listRefund(this.queryParams).then(response => {
        this.refundList = response.rows;
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
        syncId: null,
        orderId: null,
		orderCode: null,
        firstName: null,
        amount: null,
        refund: null,
        user1Id: null,
		user1Name: null,
        user2Id: null,
		user2Name: null,
        commit1Date: null,
        commit2Date: null,
        wxStatus: null,
        wxResult: null,
        syncFlag: null,
        remark: null,
        createBy: null,
        createTime: null,
		checkStep: null
      };
      this.resetForm("form");
    },
	getList4Status(value){
		  this.queryParams.checkStep = value;
	      this.getList();
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
      this.title = "添加退款单";
    },
	/** 审核按钮操作 */
    handleCheck(row, step) {
	  row.checkStep = step;
	  var msg = "协议号:"+row.orderCode+"\r\n甲方姓名:"+row.firstName+"\r\n退款金额:"+row.refund+" 进行退款操作吗?";
	  if (!confirm(msg)) {
	          return ;
	  }
	  
	  checkRefund(row).then(response => {
		this.$modal.msgSuccess("审核通过");
		this.open = false;
		this.getList();
	  });
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getRefund(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改退款单";
      });
    },
	/** 同步按钮操作 */
    sync() {
		if (this.form.id != null) {
	        syncRefund(this.form.id).then(response => {
	          this.$modal.msgSuccess("同步完成");
	          this.open = false;
	          this.getList();
			});
	    }
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateRefund(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addRefund(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除退款单编号为"' + ids + '"的数据项？').then(function() {
        return delRefund(ids);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/refund/export', {
        ...this.queryParams
      }, `refund_${new Date().getTime()}.xlsx`)
    },
	/** 导出按钮操作 */
    viewCheckButton(flag) {
      	if(this.$store.getters.roles.includes('accountant') && flag==2|| flag ==0)
	  		return true;
		if(this.$store.getters.roles.includes('cashier') && (flag==1 || flag ==0))
			return true;
		return false;
    }
  }
};
</script>
