# install.packages("igraph")

library(igraph)


# two column matrix of edges
retweeter_poster = cbind(quem_retweetou, quem_postou)

# generate graph
rt_graph = graph.edgelist(retweeter_poster)

# get vertex names
ver_labs = get.vertex.attribute(rt_graph, "name", index=V(rt_graph))

# save(tweets_g,file = "tweets_g")
glay_kk = layout_with_kk(rt_graph)
glay_dh = layout_with_dh(rt_graph,
                         maxiter = 10,#Number of iterations to perform in the first phase
                         fineiter = max(10, log2(vcount(rt_graph))),#Number of iterations in 
                         # the fine tuning phase.
                         cool.fact = 0.75,#Cooling factor.
                         weight.node.dist = 1,#Weight for the node-node distances component
                         # of the energy function.
                         weight.border = 0,#Weight for the distance from the border component
                         # of the energy function. It can be set to zero, if vertices are
                         # allowed to sit on the border.
                         weight.edge.lengths = edge_density(rt_graph)/10,#Weight for the edge
                         # length component of the energy function.
                         weight.edge.crossings = 1 - sqrt(edge_density(rt_graph)),#Weight for the
                         # edge crossing component of the energy function.
                         weight.node.edge.dist = 0.2 * (1 - edge_density(rt_graph))#Weight for the
                         # node-edge distance component of the energy function.
                         )

glay_drl = layout_with_drl(rt_graph)
glay_fr = layout_with_fr(rt_graph)
glay_gem = layout_with_gem(rt_graph)
glay_graphpot = layout_with_graphopt(rt_graph)
glay_lgl = layout_with_lgl(rt_graph)
glay_mds = layout_with_mds(rt_graph)
glay_sugiyama = layout_with_sugiyama(rt_graph)
save(glay_dh,"glay_dh")
# (rt_graph)
deg <- degree(rt_graph, mode="all")
deg <- ifelse(deg<15,1,deg)
# summary(deg)
# sum(deg>=50)
# plot
plot.new()
par(mar = c(0, 0, 0, 0))
# par(bg="white", mar=c(1,1,1,1))
# png("noLegend.png", width = 400, height = 400)
p <- plot(rt_graph, layout=glay_dh,
     vertex.color="black",
     vertex.size=1,
     vertex.label=ver_labs,
     vertex.label.family="sans",
     vertex.shape="none",
     vertex.label.color=ifelse(deg==1,hsv(h=.165, s=.28, v=.08, alpha=0),hsv(h=.165, s=.28, v=.08, alpha=1)),
     vertex.label.cex=log(deg)*0.9,
     edge.arrow.size=0,
     edge.arrow.width=0,
     edge.width=1,
     remove.loops = TRUE,
     edge.color=hsv(h=ifelse(sentiment_bin=="Negative",0.05,.400), s=1, v=1, alpha=0.6)
     )
     # edge.color=ifelse(sentiment_bin=="Negative","red","blue"))
# summary(deg)
     # edge.color=hsv(h=0, s=0, v=1, alpha=1))
# add title
title("#UsoMascaraEleNao",cex.main=5, col.main="black",outer = FALSE, line = -3)
# setup for no margins on the legend
# par(mar = c(0, 0, 0, 0))
legend('topright',title = "Sentimento",legend=c("Negativo", "Positivo"), lty=1,lwd=6,
       col=c(hsv(h=0.05, s=1, v=1, alpha=1),hsv(h=0.4, s=1, v=1, alpha=1)),bty = "n",
       cex = 0.8, horiz = F,
       pt.cex=1)




legend("topleft", legend=c("Negativo", "Positivo"),
       col=c(hsv(h=0.05, s=1, v=1, alpha=1),hsv(h=0.4, s=1, v=1, alpha=1)), 
       lty=1, #linetype
       lwd=4,
       title = "Sentimento",
       bty = "n", 
       pt.cex = 8, 
       text.col = "black", 
       horiz = F,
       box.lwd=2,y.intersp = 0.3)

library(legend)
library(network)
library(sna)
library(intergraph)
library(network)

devtools::install_github("briatte/ggnet")
library(ggnet)
net <- asNetwork(simplify(rt_graph))
ggnet2(net,mode = "undirected") %>% plot(.,layout=glay_dh)

class(rt_graph)
as.network(rt_graph,matrix.type="edgelist")
igraph:
        