﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QuanLiThuVien.Models;
using Limilabs.Barcode;
using System.Web.Helpers;
using System.Drawing;
using System.Web.UI.DataVisualization;
using System.Web.UI.DataVisualization.Charting;
using System.IO;
using System.Net.Mail;
using System.Net;

namespace QuanLiThuVien.Controllers
{
    public class HomeController : Controller
    {
        public static QLThuVienEntities4 ql;
        public ActionResult Index()
        {
            ql = new QLThuVienEntities4();
            return View();
        }
        public ActionResult LogOut()
        {
            Session["username"] = null;
            Session["loai"] = null;
            return RedirectToAction("Index");
        }
        [HttpPost]
        public PartialViewResult EditInfo(string load_Layout)
        {
            ViewBag.load_Layout = load_Layout;
            if (Session["username"] != null)
            {
                EditInfo_i i = new EditInfo_i();
                string user=Session["username"].ToString();
                int loai=int.Parse(Session["loai"].ToString());
                if (loai > 0)
                {
                    tbl_NhanVien nv = (from n in ql.tbl_NhanVien where n.ID == user select n).First();
                    i.loai = "nv";
                    i.DiaChi = nv.DiaChi;
                    i.Email = nv.Email;
                    i.SDT = nv.SDT;
                    i.pass = nv.Password;
                }
                else
                {
                    tbl_DocGia dg = (from n in ql.tbl_DocGia where n.ID == user select n).First();
                    i.loai = "dg";
                    i.DiaChi = dg.DiaChi;
                    i.Email = dg.Email;
                    i.SDT = dg.SDT;
                    i.pass = dg.Pass;                    
                }
                return PartialView("EditInfo", i);
            }
            else
                return null;
        }
        [HttpPost]
        public ActionResult UpdateInfo(EditInfo_i n)
        {
            if (Session["username"] != null)
            {
                string user = Session["username"].ToString();
                if (n.loai=="nv")
                {
                    //QLThuVienEntities2 ql1 = new QLThuVienEntities2();
                    tbl_NhanVien nv = (from k in ql.tbl_NhanVien where k.ID == user select k).First();
                    nv.DiaChi = n.DiaChi;
                    nv.SDT = n.SDT;
                    nv.Email = n.Email;
                    nv.Password = n.newpass;
                    ql.SaveChanges();
                }
                else
                {                    
                    tbl_DocGia dg = (from h in ql.tbl_DocGia where h.ID == user select h).First();
                    dg.DiaChi = n.DiaChi;
                    dg.Email = n.Email;
                    dg.SDT = n.SDT;
                    dg.Pass = n.newpass;
                    ql.SaveChanges();
                }                
            }
            return PartialView("EditInfo", "1");
        }
    }
}
